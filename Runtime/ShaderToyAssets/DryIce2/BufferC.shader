Shader "ShaderToy/Dry Ice 2/BufferC"
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


            float div(vec2 gl_FragCoord,int x, int y)
            {
                return texelFetch(iChannel0, ivec2(gl_FragCoord.xy) + ivec2(x, y), 0).x;
            }

            float getDiv(vec2 gl_FragCoord)
            {
                float p = 0.;
                p += 1. * div(gl_FragCoord,-9, 0);
                p += 9. * div(gl_FragCoord,-8, -1);
                p += 4. * div(gl_FragCoord,-8, 0);
                p += 9. * div(gl_FragCoord,-8, 1);
                p += 36. * div(gl_FragCoord,-7, -2);
                p += 32. * div(gl_FragCoord,-7, -1);
                p += 97. * div(gl_FragCoord,-7, 0);
                p += 32. * div(gl_FragCoord,-7, 1);
                p += 36. * div(gl_FragCoord,-7, 2);
                p += 84. * div(gl_FragCoord,-6, -3);
                p += 112. * div(gl_FragCoord,-6, -2);
                p += 436. * div(gl_FragCoord,-6, -1);
                p += 320. * div(gl_FragCoord,-6, 0);
                p += 436. * div(gl_FragCoord,-6, 1);
                p += 112. * div(gl_FragCoord,-6, 2);
                p += 84. * div(gl_FragCoord,-6, 3);
                p += 126. * div(gl_FragCoord,-5, -4);
                p += 224. * div(gl_FragCoord,-5, -3);
                p += 1092. * div(gl_FragCoord,-5, -2);
                p += 1280. * div(gl_FragCoord,-5, -1);
                p += 2336. * div(gl_FragCoord,-5, 0);
                p += 1280. * div(gl_FragCoord,-5, 1);
                p += 1092. * div(gl_FragCoord,-5, 2);
                p += 224. * div(gl_FragCoord,-5, 3);
                p += 126. * div(gl_FragCoord,-5, 4);
                p += 126. * div(gl_FragCoord,-4, -5);
                p += 280. * div(gl_FragCoord,-4, -4);
                p += 1694. * div(gl_FragCoord,-4, -3);
                p += 2752. * div(gl_FragCoord,-4, -2);
                p += 6656. * div(gl_FragCoord,-4, -1);
                p += 6464. * div(gl_FragCoord,-4, 0);
                p += 6656. * div(gl_FragCoord,-4, 1);
                p += 2752. * div(gl_FragCoord,-4, 2);
                p += 1694. * div(gl_FragCoord,-4, 3);
                p += 280. * div(gl_FragCoord,-4, 4);
                p += 126. * div(gl_FragCoord,-4, 5);
                p += 84. * div(gl_FragCoord,-3, -6);
                p += 224. * div(gl_FragCoord,-3, -5);
                p += 1694. * div(gl_FragCoord,-3, -4);
                p += 3520. * div(gl_FragCoord,-3, -3);
                p += 11016. * div(gl_FragCoord,-3, -2);
                p += 16128. * div(gl_FragCoord,-3, -1);
                p += 24608. * div(gl_FragCoord,-3, 0);
                p += 16128. * div(gl_FragCoord,-3, 1);
                p += 11016. * div(gl_FragCoord,-3, 2);
                p += 3520. * div(gl_FragCoord,-3, 3);
                p += 1694. * div(gl_FragCoord,-3, 4);
                p += 224. * div(gl_FragCoord,-3, 5);
                p += 84. * div(gl_FragCoord,-3, 6);
                p += 36. * div(gl_FragCoord,-2, -7);
                p += 112. * div(gl_FragCoord,-2, -6);
                p += 1092. * div(gl_FragCoord,-2, -5);
                p += 2752. * div(gl_FragCoord,-2, -4);
                p += 11016. * div(gl_FragCoord,-2, -3);
                p += 21664. * div(gl_FragCoord,-2, -2);
                p += 47432. * div(gl_FragCoord,-2, -1);
                p += 59712. * div(gl_FragCoord,-2, 0);
                p += 47432. * div(gl_FragCoord,-2, 1);
                p += 21664. * div(gl_FragCoord,-2, 2);
                p += 11016. * div(gl_FragCoord,-2, 3);
                p += 2752. * div(gl_FragCoord,-2, 4);
                p += 1092. * div(gl_FragCoord,-2, 5);
                p += 112. * div(gl_FragCoord,-2, 6);
                p += 36. * div(gl_FragCoord,-2, 7);
                p += 9. * div(gl_FragCoord,-1, -8);
                p += 32. * div(gl_FragCoord,-1, -7);
                p += 436. * div(gl_FragCoord,-1, -6);
                p += 1280. * div(gl_FragCoord,-1, -5);
                p += 6656. * div(gl_FragCoord,-1, -4);
                p += 16128. * div(gl_FragCoord,-1, -3);
                p += 47432. * div(gl_FragCoord,-1, -2);
                p += 92224. * div(gl_FragCoord,-1, -1);
                p += 163476. * div(gl_FragCoord,-1, 0);
                p += 92224. * div(gl_FragCoord,-1, 1);
                p += 47432. * div(gl_FragCoord,-1, 2);
                p += 16128. * div(gl_FragCoord,-1, 3);
                p += 6656. * div(gl_FragCoord,-1, 4);
                p += 1280. * div(gl_FragCoord,-1, 5);
                p += 436. * div(gl_FragCoord,-1, 6);
                p += 32. * div(gl_FragCoord,-1, 7);
                p += 9. * div(gl_FragCoord,-1, 8);
                p += 1. * div(gl_FragCoord,0, -9);
                p += 4. * div(gl_FragCoord,0, -8);
                p += 97. * div(gl_FragCoord,0, -7);
                p += 320. * div(gl_FragCoord,0, -6);
                p += 2336. * div(gl_FragCoord,0, -5);
                p += 6464. * div(gl_FragCoord,0, -4);
                p += 24608. * div(gl_FragCoord,0, -3);
                p += 59712. * div(gl_FragCoord,0, -2);
                p += 163476. * div(gl_FragCoord,0, -1);
                p += 409744. * div(gl_FragCoord,0, 0);
                p += 163476. * div(gl_FragCoord,0, 1);
                p += 59712. * div(gl_FragCoord,0, 2);
                p += 24608. * div(gl_FragCoord,0, 3);
                p += 6464. * div(gl_FragCoord,0, 4);
                p += 2336. * div(gl_FragCoord,0, 5);
                p += 320. * div(gl_FragCoord,0, 6);
                p += 97. * div(gl_FragCoord,0, 7);
                p += 4. * div(gl_FragCoord,0, 8);
                p += 1. * div(gl_FragCoord,0, 9);
                p += 9. * div(gl_FragCoord,1, -8);
                p += 32. * div(gl_FragCoord,1, -7);
                p += 436. * div(gl_FragCoord,1, -6);
                p += 1280. * div(gl_FragCoord,1, -5);
                p += 6656. * div(gl_FragCoord,1, -4);
                p += 16128. * div(gl_FragCoord,1, -3);
                p += 47432. * div(gl_FragCoord,1, -2);
                p += 92224. * div(gl_FragCoord,1, -1);
                p += 163476. * div(gl_FragCoord,1, 0);
                p += 92224. * div(gl_FragCoord,1, 1);
                p += 47432. * div(gl_FragCoord,1, 2);
                p += 16128. * div(gl_FragCoord,1, 3);
                p += 6656. * div(gl_FragCoord,1, 4);
                p += 1280. * div(gl_FragCoord,1, 5);
                p += 436. * div(gl_FragCoord,1, 6);
                p += 32. * div(gl_FragCoord,1, 7);
                p += 9. * div(gl_FragCoord,1, 8);
                p += 36. * div(gl_FragCoord,2, -7);
                p += 112. * div(gl_FragCoord,2, -6);
                p += 1092. * div(gl_FragCoord,2, -5);
                p += 2752. * div(gl_FragCoord,2, -4);
                p += 11016. * div(gl_FragCoord,2, -3);
                p += 21664. * div(gl_FragCoord,2, -2);
                p += 47432. * div(gl_FragCoord,2, -1);
                p += 59712. * div(gl_FragCoord,2, 0);
                p += 47432. * div(gl_FragCoord,2, 1);
                p += 21664. * div(gl_FragCoord,2, 2);
                p += 11016. * div(gl_FragCoord,2, 3);
                p += 2752. * div(gl_FragCoord,2, 4);
                p += 1092. * div(gl_FragCoord,2, 5);
                p += 112. * div(gl_FragCoord,2, 6);
                p += 36. * div(gl_FragCoord,2, 7);
                p += 84. * div(gl_FragCoord,3, -6);
                p += 224. * div(gl_FragCoord,3, -5);
                p += 1694. * div(gl_FragCoord,3, -4);
                p += 3520. * div(gl_FragCoord,3, -3);
                p += 11016. * div(gl_FragCoord,3, -2);
                p += 16128. * div(gl_FragCoord,3, -1);
                p += 24608. * div(gl_FragCoord,3, 0);
                p += 16128. * div(gl_FragCoord,3, 1);
                p += 11016. * div(gl_FragCoord,3, 2);
                p += 3520. * div(gl_FragCoord,3, 3);
                p += 1694. * div(gl_FragCoord,3, 4);
                p += 224. * div(gl_FragCoord,3, 5);
                p += 84. * div(gl_FragCoord,3, 6);
                p += 126. * div(gl_FragCoord,4, -5);
                p += 280. * div(gl_FragCoord,4, -4);
                p += 1694. * div(gl_FragCoord,4, -3);
                p += 2752. * div(gl_FragCoord,4, -2);
                p += 6656. * div(gl_FragCoord,4, -1);
                p += 6464. * div(gl_FragCoord,4, 0);
                p += 6656. * div(gl_FragCoord,4, 1);
                p += 2752. * div(gl_FragCoord,4, 2);
                p += 1694. * div(gl_FragCoord,4, 3);
                p += 280. * div(gl_FragCoord,4, 4);
                p += 126. * div(gl_FragCoord,4, 5);
                p += 126. * div(gl_FragCoord,5, -4);
                p += 224. * div(gl_FragCoord,5, -3);
                p += 1092. * div(gl_FragCoord,5, -2);
                p += 1280. * div(gl_FragCoord,5, -1);
                p += 2336. * div(gl_FragCoord,5, 0);
                p += 1280. * div(gl_FragCoord,5, 1);
                p += 1092. * div(gl_FragCoord,5, 2);
                p += 224. * div(gl_FragCoord,5, 3);
                p += 126. * div(gl_FragCoord,5, 4);
                p += 84. * div(gl_FragCoord,6, -3);
                p += 112. * div(gl_FragCoord,6, -2);
                p += 436. * div(gl_FragCoord,6, -1);
                p += 320. * div(gl_FragCoord,6, 0);
                p += 436. * div(gl_FragCoord,6, 1);
                p += 112. * div(gl_FragCoord,6, 2);
                p += 84. * div(gl_FragCoord,6, 3);
                p += 36. * div(gl_FragCoord,7, -2);
                p += 32. * div(gl_FragCoord,7, -1);
                p += 97. * div(gl_FragCoord,7, 0);
                p += 32. * div(gl_FragCoord,7, 1);
                p += 36. * div(gl_FragCoord,7, 2);
                p += 9. * div(gl_FragCoord,8, -1);
                p += 4. * div(gl_FragCoord,8, 0);
                p += 9. * div(gl_FragCoord,8, 1);
                p += 1. * div(gl_FragCoord,9, 0);
                return p / 1048576.;
            }

            float pre(vec2 gl_FragCoord,int x, int y)
            {
                return texelFetch(iChannel1, ivec2(gl_FragCoord.xy) + ivec2(x, y), 0).x;
            }

            float getPre(vec2 gl_FragCoord)
            {
                float p = 0.;
                p += 1. * pre(gl_FragCoord,-10, 0);
                p += 10. * pre(gl_FragCoord,-9, -1);
                p += 10. * pre(gl_FragCoord,-9, 1);
                p += 45. * pre(gl_FragCoord,-8, -2);
                p += 100. * pre(gl_FragCoord,-8, 0);
                p += 45. * pre(gl_FragCoord,-8, 2);
                p += 120. * pre(gl_FragCoord,-7, -3);
                p += 450. * pre(gl_FragCoord,-7, -1);
                p += 450. * pre(gl_FragCoord,-7, 1);
                p += 120. * pre(gl_FragCoord,-7, 3);
                p += 210. * pre(gl_FragCoord,-6, -4);
                p += 1200. * pre(gl_FragCoord,-6, -2);
                p += 2025. * pre(gl_FragCoord,-6, 0);
                p += 1200. * pre(gl_FragCoord,-6, 2);
                p += 210. * pre(gl_FragCoord,-6, 4);
                p += 252. * pre(gl_FragCoord,-5, -5);
                p += 2100. * pre(gl_FragCoord,-5, -3);
                p += 5400. * pre(gl_FragCoord,-5, -1);
                p += 5400. * pre(gl_FragCoord,-5, 1);
                p += 2100. * pre(gl_FragCoord,-5, 3);
                p += 252. * pre(gl_FragCoord,-5, 5);
                p += 210. * pre(gl_FragCoord,-4, -6);
                p += 2520. * pre(gl_FragCoord,-4, -4);
                p += 9450. * pre(gl_FragCoord,-4, -2);
                p += 14400. * pre(gl_FragCoord,-4, 0);
                p += 9450. * pre(gl_FragCoord,-4, 2);
                p += 2520. * pre(gl_FragCoord,-4, 4);
                p += 210. * pre(gl_FragCoord,-4, 6);
                p += 120. * pre(gl_FragCoord,-3, -7);
                p += 2100. * pre(gl_FragCoord,-3, -5);
                p += 11340. * pre(gl_FragCoord,-3, -3);
                p += 25200. * pre(gl_FragCoord,-3, -1);
                p += 25200. * pre(gl_FragCoord,-3, 1);
                p += 11340. * pre(gl_FragCoord,-3, 3);
                p += 2100. * pre(gl_FragCoord,-3, 5);
                p += 120. * pre(gl_FragCoord,-3, 7);
                p += 45. * pre(gl_FragCoord,-2, -8);
                p += 1200. * pre(gl_FragCoord,-2, -6);
                p += 9450. * pre(gl_FragCoord,-2, -4);
                p += 30240. * pre(gl_FragCoord,-2, -2);
                p += 44100. * pre(gl_FragCoord,-2, 0);
                p += 30240. * pre(gl_FragCoord,-2, 2);
                p += 9450. * pre(gl_FragCoord,-2, 4);
                p += 1200. * pre(gl_FragCoord,-2, 6);
                p += 45. * pre(gl_FragCoord,-2, 8);
                p += 10. * pre(gl_FragCoord,-1, -9);
                p += 450. * pre(gl_FragCoord,-1, -7);
                p += 5400. * pre(gl_FragCoord,-1, -5);
                p += 25200. * pre(gl_FragCoord,-1, -3);
                p += 52920. * pre(gl_FragCoord,-1, -1);
                p += 52920. * pre(gl_FragCoord,-1, 1);
                p += 25200. * pre(gl_FragCoord,-1, 3);
                p += 5400. * pre(gl_FragCoord,-1, 5);
                p += 450. * pre(gl_FragCoord,-1, 7);
                p += 10. * pre(gl_FragCoord,-1, 9);
                p += 1. * pre(gl_FragCoord,0, -10);
                p += 100. * pre(gl_FragCoord,0, -8);
                p += 2025. * pre(gl_FragCoord,0, -6);
                p += 14400. * pre(gl_FragCoord,0, -4);
                p += 44100. * pre(gl_FragCoord,0, -2);
                p += 63504. * pre(gl_FragCoord,0, 0);
                p += 44100. * pre(gl_FragCoord,0, 2);
                p += 14400. * pre(gl_FragCoord,0, 4);
                p += 2025. * pre(gl_FragCoord,0, 6);
                p += 100. * pre(gl_FragCoord,0, 8);
                p += 1. * pre(gl_FragCoord,0, 10);
                p += 10. * pre(gl_FragCoord,1, -9);
                p += 450. * pre(gl_FragCoord,1, -7);
                p += 5400. * pre(gl_FragCoord,1, -5);
                p += 25200. * pre(gl_FragCoord,1, -3);
                p += 52920. * pre(gl_FragCoord,1, -1);
                p += 52920. * pre(gl_FragCoord,1, 1);
                p += 25200. * pre(gl_FragCoord,1, 3);
                p += 5400. * pre(gl_FragCoord,1, 5);
                p += 450. * pre(gl_FragCoord,1, 7);
                p += 10. * pre(gl_FragCoord,1, 9);
                p += 45. * pre(gl_FragCoord,2, -8);
                p += 1200. * pre(gl_FragCoord,2, -6);
                p += 9450. * pre(gl_FragCoord,2, -4);
                p += 30240. * pre(gl_FragCoord,2, -2);
                p += 44100. * pre(gl_FragCoord,2, 0);
                p += 30240. * pre(gl_FragCoord,2, 2);
                p += 9450. * pre(gl_FragCoord,2, 4);
                p += 1200. * pre(gl_FragCoord,2, 6);
                p += 45. * pre(gl_FragCoord,2, 8);
                p += 120. * pre(gl_FragCoord,3, -7);
                p += 2100. * pre(gl_FragCoord,3, -5);
                p += 11340. * pre(gl_FragCoord,3, -3);
                p += 25200. * pre(gl_FragCoord,3, -1);
                p += 25200. * pre(gl_FragCoord,3, 1);
                p += 11340. * pre(gl_FragCoord,3, 3);
                p += 2100. * pre(gl_FragCoord,3, 5);
                p += 120. * pre(gl_FragCoord,3, 7);
                p += 210. * pre(gl_FragCoord,4, -6);
                p += 2520. * pre(gl_FragCoord,4, -4);
                p += 9450. * pre(gl_FragCoord,4, -2);
                p += 14400. * pre(gl_FragCoord,4, 0);
                p += 9450. * pre(gl_FragCoord,4, 2);
                p += 2520. * pre(gl_FragCoord,4, 4);
                p += 210. * pre(gl_FragCoord,4, 6);
                p += 252. * pre(gl_FragCoord,5, -5);
                p += 2100. * pre(gl_FragCoord,5, -3);
                p += 5400. * pre(gl_FragCoord,5, -1);
                p += 5400. * pre(gl_FragCoord,5, 1);
                p += 2100. * pre(gl_FragCoord,5, 3);
                p += 252. * pre(gl_FragCoord,5, 5);
                p += 210. * pre(gl_FragCoord,6, -4);
                p += 1200. * pre(gl_FragCoord,6, -2);
                p += 2025. * pre(gl_FragCoord,6, 0);
                p += 1200. * pre(gl_FragCoord,6, 2);
                p += 210. * pre(gl_FragCoord,6, 4);
                p += 120. * pre(gl_FragCoord,7, -3);
                p += 450. * pre(gl_FragCoord,7, -1);
                p += 450. * pre(gl_FragCoord,7, 1);
                p += 120. * pre(gl_FragCoord,7, 3);
                p += 45. * pre(gl_FragCoord,8, -2);
                p += 100. * pre(gl_FragCoord,8, 0);
                p += 45. * pre(gl_FragCoord,8, 2);
                p += 10. * pre(gl_FragCoord,9, -1);
                p += 10. * pre(gl_FragCoord,9, 1);
                p += 1. * pre(gl_FragCoord,10, 0);
                return p / 1048576.;
            }

            float4 frag(v2f i) : SV_Target
            {
                vec2 uv = i.uv;
                vec2 fragCoord = uv * iResolution.xy;

                float div = getDiv(fragCoord);
                float p = getPre(fragCoord) - div;
                half4 fragColor = vec4(p, div, vec2(1,1));
                return fragColor;
            }
            ENDHLSL
        }
    }
}