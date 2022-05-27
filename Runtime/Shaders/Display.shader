Shader "Unlit/Display"
{
    Properties
    {
        iChannel0 ("channel0", 2D) = "white" {}
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
            #include "./ShaderToyBase.hlsl"


            float4 frag(v2f i) : SV_Target
            {
                float4 col = tex2D(iChannel0, i.uv);
                return col;
            }
            ENDHLSL
        }
    }
}