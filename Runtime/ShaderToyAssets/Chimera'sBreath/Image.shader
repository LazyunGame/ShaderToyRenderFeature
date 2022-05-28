Shader "ShaderToy/Chimera's Breath/Image"
{
    Properties
    {
        iChannel0 ("Texture", 2D) = "white" {}

    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "../../../Runtime/Shaders/ShaderToyBase.hlsl"

           


            float4 frag(v2f i) : SV_Target
            {
                vec2 uv = i.uv;
                vec2 fragCoord = uv * iResolution.xy;
                vec4 col = textureLod(iChannel0, uv, 0.);
                // if (fragCoord.y < 1. || fragCoord.y >= (iResolution.y - 1.))
                //     col = vec4(0, 0, 0, 0);
                return col;
            }
            ENDHLSL
        }
    }
}