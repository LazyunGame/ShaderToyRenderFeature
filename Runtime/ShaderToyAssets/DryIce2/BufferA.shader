Shader "ShaderToy/Dry Ice 2/BufferA"
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


            float noise(vec3 p)
            {
                vec3 ip = floor(p);
                p -= ip;
                vec3 s = vec3(7, 157, 113);
                vec4 h = vec4(0., s.yz, s.y + s.z) + dot(ip, s);
                p = p * p * (3. - 2. * p);
                h = mix(fract(sin(h) * 43758.5),fract(sin(h + s.x) * 43758.5), p.x);
                h.xy = mix(h.xz, h.yw, p.y);
                return mix(h.x, h.y, p.z);
            }

            vec2 fbm(vec3 p, int octaveNum)
            {
                vec2 acc = vec2(0, 0);
                float freq = 1.0;
                float amp = 0.5;
                vec3 shift = vec3(100, 100, 100);
                for (int i = 0; i < octaveNum; i++)
                {
                    acc += vec2(noise(p), noise(p + vec3(0, 0, 10))) * amp;
                    p = p * 2.0 + shift;
                    amp *= 0.5;
                }
                return acc;
            }


            vec3 sampleMinusGradient(vec2 coord)
            {
                vec3 veld = texture(iChannel1, coord / iResolution.xy).xyz;
                float left = texture(iChannel0, (coord + vec2(-1, 0)) / iResolution.xy).x;
                float right = texture(iChannel0, (coord + vec2(1, 0)) / iResolution.xy).x;
                float bottom = texture(iChannel0, (coord + vec2(0, -1)) / iResolution.xy).x;
                float top = texture(iChannel0, (coord + vec2(0, 1)) / iResolution.xy).x;
                vec2 grad = vec2(right - left, top - bottom) * 0.5;
                return vec3(veld.xy - grad, veld.z);
            }

            vec3 vignette(vec3 color, vec2 q, float v)
            {
                color *= mix(1., pow(16.0 * q.x * q.y * (1.0 - q.x) * (1.0 - q.y), v), 0.02);
                return color;
            }

            float4 frag(v2f input) : SV_Target
            {
                vec2 uv = input.uv;
                vec2 fragCoord = uv * iResolution.xy;
                float dissipation = 0.95;

float ballRadius = 0.06;
float fogHeigth = .24; //ballRadius * 4.;
// int	nbSlice			= 24;
float fogSlice = .01; //fogHeigth / float(nbSlice);
int nbSphere = 3;
float shadowDensity = 25.;
float fogDensity = 20.;
float lightHeight = 1.;
                // Euler advection
                vec2 velocity = sampleMinusGradient(fragCoord).xy;
                vec3 veld = sampleMinusGradient(fragCoord - dissipation * velocity).xyz;
                float density = veld.z;
                velocity = veld.xy;

                // vec2	uv = (2. * fragCoord - iResolution.xy) / iResolution.y;
                // Small perturbation
                vec2 detailNoise = fbm(vec3(uv * 40., iTime * 0.5 + 30.), 7) - 0.5;
                velocity += detailNoise * 0.2;
                density += length(detailNoise) * 0.01;

                // Injection
                vec2 injectionNoise = fbm(vec3(uv * 1.5, iTime * 0.1 + 30.), 7) - 0.5;
                velocity += injectionNoise * 0.1;
                density += max((length(injectionNoise) * 0.04), 0.);

                // Inject emiter
                float influenceRadius = ballRadius * 2.;
                for (int i = 0; i < nbSphere; i++)
                {
                    vec2 p = spherePosition(i, iFrame);
                    float dist = distance(uv, p);
                    if (dist < influenceRadius)
                    {
                        vec2 op = spherePosition(i, iFrame + 1);
                        vec2 ballVelocity = p - op;
                        density -= ((influenceRadius - dist) / influenceRadius) * 0.15;
                        density = max(0., density);
                        velocity -= ballVelocity * 5.;
                    }
                }
                density = min(1., density);
                density *= 0.99; // damp
                veld = vec3(vec3(velocity, density));
                veld = vignette(veld, fragCoord / iResolution.xy, 1.);
                half4 fragColor = vec4(veld, 1);
                return fragColor;
            }
            ENDHLSL
        }
    }
}