using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Lazyun.Runtime
{
    public class ShaderToyPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "ShaderToyPass";

        private bool drawToScreen, useScreenMouse;
        private ShaderToyAsset shaderToyAsset;

        private RenderTargetIdentifier cameraColorTarget;
        private string finalTextureName;
        private float textureScale;

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            bool isSceneViewCamera = cameraData.isSceneViewCamera;
            if (isSceneViewCamera)
            {
                return;
            }

            if (!shaderToyAsset)
            {
                return;
            }

            if (useScreenMouse)
            {
                Vector4 p = Input.mousePosition;
                p.z = 3;
                // Debug.Log(p);
                shaderToyAsset.SetMousePosition(p);
            }

            shaderToyAsset.Render(context, textureScale);


            if (drawToScreen)
            {
                CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
                cmd.SetRenderTarget(cameraColorTarget);
                cmd.ClearRenderTarget(true, true, Color.clear);
                Blit(cmd, shaderToyAsset.image.RenderTexture, cameraColorTarget);
                context.ExecuteCommandBuffer(cmd);


                cmd.Clear();
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
            else
            {
                if (!string.IsNullOrEmpty(finalTextureName))
                    Shader.SetGlobalTexture(finalTextureName, shaderToyAsset.image.RenderTexture);
            }
        }

        public void Setup(ShaderToyAsset asset, bool drawToScreen,
            RenderTargetIdentifier rendererCameraColorTarget, string renderTargetName, float texScale,
            bool useScreenMousePos)
        {
            shaderToyAsset = asset;
            this.drawToScreen = drawToScreen;
            renderPassEvent = RenderPassEvent.AfterRenderingSkybox;
            cameraColorTarget = rendererCameraColorTarget;
            finalTextureName = renderTargetName;
            textureScale = texScale;
            useScreenMouse = useScreenMousePos;
        }
    }
}