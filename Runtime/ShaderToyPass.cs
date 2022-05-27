using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Lazyun.Runtime
{
    public class ShaderToyPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "ShaderToyPass";

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

            shaderToyAsset.Render(context);


            if (drawToScreen)
            {
                CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
                Blit(cmd, shaderToyAsset.image.RenderTexture, cameraColorTarget);
                context.ExecuteCommandBuffer(cmd);


                cmd.Clear();
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
        }

        public void Setup(ShaderToyAsset asset, bool drawToScreen, RenderTargetIdentifier rendererCameraColorTarget)
        {
            shaderToyAsset = asset;
            this.drawToScreen = drawToScreen;
            renderPassEvent = RenderPassEvent.AfterRenderingSkybox;
            cameraColorTarget = rendererCameraColorTarget;
        }
    }
}