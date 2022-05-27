using System;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;

namespace Lazyun.Runtime
{
    public enum ChannelEnum
    {
        none,
        image,
        bufferA,
        bufferB,
        bufferC,
        bufferD
    }

    [Serializable]
    public class ShaderToyChannel
    {
        public ChannelEnum bufferName = ChannelEnum.none;

        public ChannelEnum[] inputBufferNames;

        public Material material;
        public int size;
        public RenderTextureFormat format = RenderTextureFormat.ARGBHalf;
        public FilterMode filterType = FilterMode.Bilinear;
        public TextureWrapMode wrapMode = TextureWrapMode.Clamp;

        [NonSerialized] public RenderTexture _rt, _rt1;

        public RenderTexture RenderTexture
        {
            get
            {
                if (!_rt)
                {
                    _rt = CreateRenderTexture(bufferName.ToString(), size);
                }

                return _rt;
            }
        }

        private RenderTexture CreateRenderTexture(string channel, int size = 0)
        {
            RenderTexture rt;
            if (size == 0)
            {
                rt = RenderTexture.GetTemporary(Screen.width, Screen.height, 0, format);
            }
            else
            {
                rt = RenderTexture.GetTemporary(size, size, 0, format);
            }

            rt.filterMode = filterType;
            rt.wrapMode = wrapMode;
            rt.autoGenerateMips = false;
            rt.Clear(Color.clear);
            rt.name = channel;
            return rt;
        }

        [NonSerialized] public ShaderToyChannel[] channels;
        [NonSerialized] public bool isConnected;

        private CommandBuffer _commandBuffer;

        public void Connect(ShaderToyChannel[] buffers)
        {
            if (bufferName == ChannelEnum.none)
            {
                return;
            }

            // material = Object.Instantiate(material);

            channels = new ShaderToyChannel[inputBufferNames.Length];
            for (int i = 0; i < inputBufferNames.Length; i++)
            {
                var name = inputBufferNames[i];
                if (name == ChannelEnum.none) continue;

                // 将Channel name 和 Channel instance 对应上
                channels[i] = buffers.First(t =>
                {
#if UNITY_EDITOR
                    // Debug.Log(t.bufferName + " --> " + name);
#endif
                    return t.bufferName == name;
                });
            }

            for (int i = 0; i < channels.Length; i++)
            {
                var c = channels[i];
                if (c != null && c.bufferName != ChannelEnum.none)
                {
                    if (c == this)
                    {
                        // 如果输入Channel中有自己这个Channel，则需要使用 double rendertexture swapping。
                        // 因为unity不支持在一个Graphic.Blit方法中，将同一个RenderTexture当作参数，又当作渲染目标
                        _rt1 = CreateRenderTexture(bufferName.ToString() + "_swap", size);
                        material.SetTexture("iChannel" + i, _rt1);
                    }
                    else
                    {
                        // 设置Shader中的对应Channel的RenderTexture
                        material.SetTexture("iChannel" + i, c.RenderTexture);
                    }
                }
            }

            // 设置常用参数
            material.SetFloat("iScreenRatio", RenderTexture.height * 1f / RenderTexture.width);
            material.SetVector("iScreenParams",
                new Vector4(Screen.width, Screen.height, Screen.width * 1f / Screen.height,
                    1));
            isConnected = true;
            _commandBuffer = new CommandBuffer();
            _commandBuffer.name = bufferName.ToString();
            // camera.AddCommandBuffer(CameraEvent.AfterSkybox, _commandBuffer);
        }

        public void Render(ScriptableRenderContext context)
        {
            if (!isConnected)
            {
                return;
            }

            if (bufferName == ChannelEnum.none)
            {
                return;
            }

            // Debug.LogError(material.GetTexture("iChannel0").name);
            _commandBuffer.Clear();
            _commandBuffer.SetRenderTarget(RenderTexture);
            _commandBuffer.Blit(Texture2D.blackTexture, RenderTexture, material, 0);
            if (_rt1)
            {
                // 如果有双Buffer swap，在这里渲染更新替换
                // Graphics.Blit(RenderTexture, _rt1);
                _commandBuffer.SetRenderTarget(_rt1);
                _commandBuffer.Blit(RenderTexture, _rt1);
            }

            context.ExecuteCommandBuffer(_commandBuffer);
        }

        public void SetMousePosition(Vector4 mousePos)
        {
            SetVector(ShaderToy.iMouse, mousePos);
        }

        public void SetVector(int name, Vector4 v)
        {
            material.SetVector(name, v);
        }

        public void SetFloat(int name, float f)
        {
            material.SetFloat(name, f);
        }

        public void SetInt(int name, int i)
        {
            material.SetInt(name, i);
        }

        public void OnDispose()
        {
            if (_commandBuffer != null)
            {
                _commandBuffer.Clear();
                _commandBuffer.Release();
            }
        }
    }
}