Shader "ShaderToy/ColorfulWaves"
{
    Properties
    {
        iWaves("Wave Count", Range(2,30)) = 8
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

      
            int iWaves;

            float wavePosition(vec2 uv, float i)
            {
                return sin((uv.x + i * 8.456) * (sin(iTime * 0.1 + 7.539 + i * 0.139) + 2.) * 0.5) * 0.65
                    + sin(uv.x * (sin(iTime * 0.1 + i * 0.2) + 2.) * 0.3) * 0.3
                    - (i - iWaves / 2.) * 2. - uv.y;
            }


            vec3 color(float x)
            {
                return colorPalette(x, vec3(0.5, 0.5, 0.5), vec3(0.5, 0.5, 0.5), vec3(2., 1., 0.),
                                    vec3(0.5, 0.2, 0.25));
            }

            float4 frag(v2f fragCoord) : SV_Target
            {
                vec2 uv = fragCoord.uv;

                vec2 waveUv = 2 * (uv - float2(.5, .5)) * (iWaves - 1.);

                float aa = iWaves * 2. / _ScreenParams.y;
                float4 fragColor;

                for (float i = 0.; i < iWaves; i++)
                {
                    float waveTop = wavePosition(waveUv, i);
                    float waveBottom = wavePosition(waveUv, i + 1.);

                    vec3 col = color(i * 0.12 + uv.x * 0.2 + iTime * 0.02);

                    col += smoothstep(0.3, 0., waveTop) * 0.05;
                    col += (1. - abs(0.5 - smoothstep(waveTop, waveBottom, 0.))) * 0.06;
                    col += smoothstep(-0.3, 0., waveBottom) * -0.05;

                    fragColor.xyz = mix(fragColor.xyz, col, smoothstep(0., aa, waveTop));
                }

                fragColor.w = 1.;
                return fragColor;
            }
            ENDHLSL
        }
    }
}