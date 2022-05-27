Shader "ShaderToy/Chimera's Breath/BufferB"
{
    Properties
    {
        iChannel0 ("Texture", 2D) = "white" {}
        iMouse("Click pos",Vector) = (0,0,0,0)
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
            #include "./Common.hlsl"
            

            float4 frag(v2f i) : SV_Target
            {
                vec2 uv = i.uv;
                vec2 fragCoord = uv * iResolution.xy;

                vec2 w = 1.0 / iResolution.xy;
                vec4 lastMouse = texelFetch(iChannel0, vec2(0, 0), 0);

                vec4 data = solveFluid(iChannel0, uv, w, iTime, iMouse.xyz, lastMouse.xyz);
                if (iFrame < 20)
                {
                    data = vec4(0.5, 0, 0, 0);
                }

                if (fragCoord.y < 1.)
                    data = iMouse;
                return data;
            }
            ENDHLSL
        }
    }
}