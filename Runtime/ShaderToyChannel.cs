using System;
using System.Linq;
using System.Runtime.Serialization;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
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
    public class RenderTextureInfo
    {
#if UNITY_EDITOR
        [EnumIntValue(new int[] {0, 32, 64, 128, 256, 512, 1024, 2048})]
#endif
        public int textureSize = 1024;

        public RenderTextureFormat format = RenderTextureFormat.ARGBHalf;
        public FilterMode filterType = FilterMode.Bilinear;
        public TextureWrapMode wrapMode = TextureWrapMode.Clamp;
        public int depthBuffer;
        public float textureScale = 1f;

        public int realSize
        {
            get { return (int) (textureSize * textureScale); }
        }

        public override bool Equals(object obj)
        {
            var b = obj as RenderTextureInfo;
            if (b == null)
            {
                return false;
            }


            return textureSize == b.textureSize
                   && format == b.format
                   && filterType == b.filterType
                   && wrapMode == b.wrapMode
                   && depthBuffer == b.depthBuffer
                   && Math.Abs(textureScale - b.textureScale) < 0.001f;
        }


        public RenderTextureInfo Clone()
        {
            return new RenderTextureInfo()
            {
                textureSize = textureSize,
                format = format,
                filterType = filterType,
                wrapMode = wrapMode,
                depthBuffer = depthBuffer,
                textureScale = textureScale
            };
        }
    }


    [Serializable]
    public class ShaderToyChannel
    {
        public ChannelEnum bufferName = ChannelEnum.none;

        public ChannelEnum[] inputBufferNames;

        public Shader shader;

        public bool overrideDescriptor;
        public RenderTextureInfo renderTextureInfo;


        [NonSerialized] public RenderTexture _rt, _rt1;
        [NonSerialized] public Material _mat;
        [NonSerialized] private ShaderToyAsset mainAsset;
        [NonSerialized] public RenderTextureInfo _cachedUsing;

        public RenderTextureInfo UsingDefaultRenderTextureInfo
        {
            get
            {
                if (overrideDescriptor || !mainAsset)
                {
                    return renderTextureInfo;
                }


                return mainAsset.defaultRenderTextureInfo;
            }
        }

        public RenderTexture RenderTexture
        {
            get
            {
                CheckOrCreateRenderTexture(bufferName.ToString(), ref _rt);
                return _rt;
            }
        }

        public Material Material
        {
            get
            {
                if (!_mat && shader)
                {
                    _mat = new Material(shader);
                }

                return _mat;
            }
        }

        public bool IsRenderTextureValid
        {
            get { return RenderTexture && Equals(UsingDefaultRenderTextureInfo, _cachedUsing); }
        }

        public bool IsReady
        {
            get { return bufferName == ChannelEnum.none || (isConnected && IsRenderTextureValid); }
        }

        private void CheckOrCreateRenderTexture(string channel, ref RenderTexture renderTexture)
        {
            if (renderTexture && Equals(UsingDefaultRenderTextureInfo, _cachedUsing))
            {
                return;
            }

            if (renderTexture)
            {
                RenderTexture.ReleaseTemporary(renderTexture);
            }

            isConnected = false;
            _cachedUsing = UsingDefaultRenderTextureInfo.Clone();
            if (_cachedUsing.textureSize == 0)
            {
                renderTexture =
                    RenderTexture.GetTemporary((int) (Screen.width * _cachedUsing.textureScale),
                        (int) (Screen.height * _cachedUsing.textureScale), 0,
                        _cachedUsing.format);
            }
            else
            {
                renderTexture = RenderTexture.GetTemporary(_cachedUsing.realSize,
                    _cachedUsing.realSize, _cachedUsing.depthBuffer,
                    _cachedUsing.format);
            }

            renderTexture.filterMode = _cachedUsing.filterType;
            renderTexture.wrapMode = _cachedUsing.wrapMode;
            renderTexture.autoGenerateMips = false;
            renderTexture.Clear(Color.clear);
            renderTexture.name = channel;
        }

        [NonSerialized] public ShaderToyChannel[] channels;
        [NonSerialized] public bool isConnected;

        private CommandBuffer _commandBuffer;

        public void Connect(ShaderToyAsset asset)
        {
            if (bufferName == ChannelEnum.none)
            {
                return;
            }

            mainAsset = asset;

            if (!Material)
            {
                return;
            }

            var buffers = asset.Channels;
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
                    c.mainAsset = asset;
                    if (c == this)
                    {
                        // 如果输入Channel中有自己这个Channel，则需要使用 double rendertexture swapping。
                        // 因为unity不支持在一个Graphic.Blit方法中，将同一个RenderTexture当作参数，又当作渲染目标
                        CheckOrCreateRenderTexture(bufferName + "_swap", ref _rt1);
                        Material.SetTexture("iChannel" + i, _rt1);
                    }
                    else
                    {
                        // 设置Shader中的对应Channel的RenderTexture
                        Material.SetTexture("iChannel" + i, c.RenderTexture);
                    }
                }
            }

           
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

            // 设置常用参数
            Material.SetFloat("iScreenRatio", RenderTexture.height * 1f / RenderTexture.width);
            Material.SetVector("iScreenParams", new Vector4(RenderTexture.width, RenderTexture.height, 
                RenderTexture.width * 1f / RenderTexture.height, 1));
            // Debug.LogError(material.GetTexture("iChannel0").name);
            _commandBuffer.Clear();
            _commandBuffer.SetRenderTarget(RenderTexture);
            _commandBuffer.Blit(Texture2D.blackTexture, RenderTexture, Material, 0);
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
            SetVector(ShaderToy.iMouse,
                new Vector4(RenderTexture.width * mousePos.x, RenderTexture.height * mousePos.y, mousePos.z, 1));
        }

        public void SetVector(int name, Vector4 v)
        {
            Material.SetVector(name, v);
        }

        public void SetFloat(int name, float f)
        {
            Material.SetFloat(name, f);
        }

        public void SetInt(int name, int i)
        {
            Material.SetInt(name, i);
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