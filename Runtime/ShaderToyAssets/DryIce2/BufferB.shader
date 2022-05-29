Shader "ShaderToy/Dry Ice 2/BufferB"
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
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "../../../Runtime/Shaders/ShaderToyBase.hlsl"
            #include "./Common.hlsl"

            #pragma vertex vert
            #pragma fragment frag


             

            float4 frag(v2f i) : SV_Target
            {
                vec2 uv = i.uv;
                vec2 fragCoord = uv * iResolution.xy;

                 ivec2 icoord = ivec2(fragCoord);
                float vel_x_left	= texelFetch(iChannel0, icoord + ivec2(-1,  0) , 0).x;
                float vel_x_right	= texelFetch(iChannel0, icoord + ivec2( 1,  0) , 0).x;
                float vel_y_bottom	= texelFetch(iChannel0, icoord + ivec2( 0, -1) , 0).y;
                float vel_y_top		= texelFetch(iChannel0, icoord + ivec2( 0,  1) , 0).y;
                float divergence	= (vel_x_right - vel_x_left + vel_y_top - vel_y_bottom) * 0.5;
                half4 fragColor = vec4(divergence,vec3(1,1,1)); 
                return fragColor;
            }
            ENDHLSL
        }
    }
}