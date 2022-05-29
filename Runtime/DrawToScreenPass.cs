using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Lazyun.Runtime
{
    public class DrawToScreenPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "DrawToScreenPass";

        private bool drawToScreen;
        private ShaderToyAsset shaderToyAsset;

        private RenderTargetIdentifier cameraColorTarget;

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


            if (drawToScreen)
            {
                CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
                cmd.SetRenderTarget(cameraColorTarget);
                cmd.ClearRenderTarget(true, true, Color.clear);
                RenderTargetIdentifier cameraTarget = (cameraData.targetTexture != null) ? new RenderTargetIdentifier(cameraData.targetTexture) : BuiltinRenderTextureType.CameraTarget;

                // cameraTarget = cameraData.postProcessEnabled?
                Blit(cmd, shaderToyAsset.image.RenderTexture, cameraTarget);
                context.ExecuteCommandBuffer(cmd);


                cmd.Clear();
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
        }

        public void Setup(ShaderToyAsset asset, bool drawToScreen,
            RenderTargetIdentifier rendererCameraColorTarget)
        {
            shaderToyAsset = asset;
            this.drawToScreen = drawToScreen;
            renderPassEvent = RenderPassEvent.AfterRendering + 10;
            cameraColorTarget = rendererCameraColorTarget;
        }
    }
}