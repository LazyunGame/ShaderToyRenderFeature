using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Lazyun.Runtime
{
    public class ShaderToyPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "ShaderToyPass";

        private bool useScreenMouse;
        private ShaderToyAsset shaderToyAsset;

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
                Vector4 p = Input.mousePosition / new Vector2(Screen.width, Screen.height);
                if (Input.GetMouseButtonDown(0))
                    p.z = 3;
                // Debug.Log(p);
                shaderToyAsset.SetMousePosition(p);
            }

            shaderToyAsset.Render(context, textureScale);


            if (!string.IsNullOrEmpty(finalTextureName))
                Shader.SetGlobalTexture(finalTextureName, shaderToyAsset.image.RenderTexture);
        }

        public void Setup(ShaderToyAsset asset, string renderTargetName, float texScale,
            bool useScreenMousePos)
        {
            shaderToyAsset = asset;
            renderPassEvent = RenderPassEvent.BeforeRendering;
            finalTextureName = renderTargetName;
            textureScale = texScale;
            useScreenMouse = useScreenMousePos;
        }
    }
}