Shader "ShaderToy/Dry Ice 2/BufferD"
{
    Properties
    {
        iChannel0 ("Texture", 2D) = "white" {}
        iChannel1 ("Texture", 2D) = "white" {}

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
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "../../../Runtime/Shaders/ShaderToyBase.hlsl"
            #include "./Common.hlsl"

            #pragma vertex vert
            #pragma fragment frag


            float div(vec2 fragCoord,int x, int y)
            {
                return texelFetch(iChannel0, ivec2(fragCoord.xy) + ivec2(x, y), 0).y;
            }

            float pre(vec2 fragCoord,int x, int y)
            {
                return texelFetch(iChannel0, ivec2(fragCoord) + ivec2(x, y), 0).x;
            }

            float getpre(vec2 fragCoord)
            {
                float p = 0.;
                p += 1. * pre(fragCoord,-10, 0);
                p += 10. * pre(fragCoord,-9, -1);
                p += 10. * pre(fragCoord,-9, 1);
                p += 45. * pre(fragCoord,-8, -2);
                p += 100. * pre(fragCoord,-8, 0);
                p += 45. * pre(fragCoord,-8, 2);
                p += 120. * pre(fragCoord,-7, -3);
                p += 450. * pre(fragCoord,-7, -1);
                p += 450. * pre(fragCoord,-7, 1);
                p += 120. * pre(fragCoord,-7, 3);
                p += 210. * pre(fragCoord,-6, -4);
                p += 1200. * pre(fragCoord,-6, -2);
                p += 2025. * pre(fragCoord,-6, 0);
                p += 1200. * pre(fragCoord,-6, 2);
                p += 210. * pre(fragCoord,-6, 4);
                p += 252. * pre(fragCoord,-5, -5);
                p += 2100. * pre(fragCoord,-5, -3);
                p += 5400. * pre(fragCoord,-5, -1);
                p += 5400. * pre(fragCoord,-5, 1);
                p += 2100. * pre(fragCoord,-5, 3);
                p += 252. * pre(fragCoord,-5, 5);
                p += 210. * pre(fragCoord,-4, -6);
                p += 2520. * pre(fragCoord,-4, -4);
                p += 9450. * pre(fragCoord,-4, -2);
                p += 14400. * pre(fragCoord,-4, 0);
                p += 9450. * pre(fragCoord,-4, 2);
                p += 2520. * pre(fragCoord,-4, 4);
                p += 210. * pre(fragCoord,-4, 6);
                p += 120. * pre(fragCoord,-3, -7);
                p += 2100. * pre(fragCoord,-3, -5);
                p += 11340. * pre(fragCoord,-3, -3);
                p += 25200. * pre(fragCoord,-3, -1);
                p += 25200. * pre(fragCoord,-3, 1);
                p += 11340. * pre(fragCoord,-3, 3);
                p += 2100. * pre(fragCoord,-3, 5);
                p += 120. * pre(fragCoord,-3, 7);
                p += 45. * pre(fragCoord,-2, -8);
                p += 1200. * pre(fragCoord,-2, -6);
                p += 9450. * pre(fragCoord,-2, -4);
                p += 30240. * pre(fragCoord,-2, -2);
                p += 44100. * pre(fragCoord,-2, 0);
                p += 30240. * pre(fragCoord,-2, 2);
                p += 9450. * pre(fragCoord,-2, 4);
                p += 1200. * pre(fragCoord,-2, 6);
                p += 45. * pre(fragCoord,-2, 8);
                p += 10. * pre(fragCoord,-1, -9);
                p += 450. * pre(fragCoord,-1, -7);
                p += 5400. * pre(fragCoord,-1, -5);
                p += 25200. * pre(fragCoord,-1, -3);
                p += 52920. * pre(fragCoord,-1, -1);
                p += 52920. * pre(fragCoord,-1, 1);
                p += 25200. * pre(fragCoord,-1, 3);
                p += 5400. * pre(fragCoord,-1, 5);
                p += 450. * pre(fragCoord,-1, 7);
                p += 10. * pre(fragCoord,-1, 9);
                p += 1. * pre(fragCoord,0, -10);
                p += 100. * pre(fragCoord,0, -8);
                p += 2025. * pre(fragCoord,0, -6);
                p += 14400. * pre(fragCoord,0, -4);
                p += 44100. * pre(fragCoord,0, -2);
                p += 63504. * pre(fragCoord,0, 0);
                p += 44100. * pre(fragCoord,0, 2);
                p += 14400. * pre(fragCoord,0, 4);
                p += 2025. * pre(fragCoord,0, 6);
                p += 100. * pre(fragCoord,0, 8);
                p += 1. * pre(fragCoord,0, 10);
                p += 10. * pre(fragCoord,1, -9);
                p += 450. * pre(fragCoord,1, -7);
                p += 5400. * pre(fragCoord,1, -5);
                p += 25200. * pre(fragCoord,1, -3);
                p += 52920. * pre(fragCoord,1, -1);
                p += 52920. * pre(fragCoord,1, 1);
                p += 25200. * pre(fragCoord,1, 3);
                p += 5400. * pre(fragCoord,1, 5);
                p += 450. * pre(fragCoord,1, 7);
                p += 10. * pre(fragCoord,1, 9);
                p += 45. * pre(fragCoord,2, -8);
                p += 1200. * pre(fragCoord,2, -6);
                p += 9450. * pre(fragCoord,2, -4);
                p += 30240. * pre(fragCoord,2, -2);
                p += 44100. * pre(fragCoord,2, 0);
                p += 30240. * pre(fragCoord,2, 2);
                p += 9450. * pre(fragCoord,2, 4);
                p += 1200. * pre(fragCoord,2, 6);
                p += 45. * pre(fragCoord,2, 8);
                p += 120. * pre(fragCoord,3, -7);
                p += 2100. * pre(fragCoord,3, -5);
                p += 11340. * pre(fragCoord,3, -3);
                p += 25200. * pre(fragCoord,3, -1);
                p += 25200. * pre(fragCoord,3, 1);
                p += 11340. * pre(fragCoord,3, 3);
                p += 2100. * pre(fragCoord,3, 5);
                p += 120. * pre(fragCoord,3, 7);
                p += 210. * pre(fragCoord,4, -6);
                p += 2520. * pre(fragCoord,4, -4);
                p += 9450. * pre(fragCoord,4, -2);
                p += 14400. * pre(fragCoord,4, 0);
                p += 9450. * pre(fragCoord,4, 2);
                p += 2520. * pre(fragCoord,4, 4);
                p += 210. * pre(fragCoord,4, 6);
                p += 252. * pre(fragCoord,5, -5);
                p += 2100. * pre(fragCoord,5, -3);
                p += 5400. * pre(fragCoord,5, -1);
                p += 5400. * pre(fragCoord,5, 1);
                p += 2100. * pre(fragCoord,5, 3);
                p += 252. * pre(fragCoord,5, 5);
                p += 210. * pre(fragCoord,6, -4);
                p += 1200. * pre(fragCoord,6, -2);
                p += 2025. * pre(fragCoord,6, 0);
                p += 1200. * pre(fragCoord,6, 2);
                p += 210. * pre(fragCoord,6, 4);
                p += 120. * pre(fragCoord,7, -3);
                p += 450. * pre(fragCoord,7, -1);
                p += 450. * pre(fragCoord,7, 1);
                p += 120. * pre(fragCoord,7, 3);
                p += 45. * pre(fragCoord,8, -2);
                p += 100. * pre(fragCoord,8, 0);
                p += 45. * pre(fragCoord,8, 2);
                p += 10. * pre(fragCoord,9, -1);
                p += 10. * pre(fragCoord,9, 1);
                p += 1. * pre(fragCoord,10, 0);
                return p / 1048576.;
            }

            float4 frag(v2f i) : SV_Target
            {
                vec2 uv = i.uv;
                vec2 fragCoord = uv * iResolution.xy;

                float p = getpre(fragCoord) - div(fragCoord,0, 0);
                half4 fragColor = vec4(p,vec3(1,1,1));

                return fragColor;
            }
            ENDHLSL
        }
    }
}