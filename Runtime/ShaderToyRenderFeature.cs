using System.Collections;
using System.Collections.Generic;
using Lazyun.Runtime;
using UnityEngine;
using UnityEngine.Experimental.Rendering.RenderGraphModule;
using UnityEngine.Rendering.Universal;

public class ShaderToyRenderFeature : ScriptableRendererFeature
{
    public ShaderToyAsset shaderToyAsset;
    public bool drawToScreen;
    public bool useScreenMouse;

    [Range(0.1f, 1)] public float textureScale;
    
    
    public string finalTextureName = "_ShaderToyFinalTexture";


    private ShaderToyPass _pass;


    public override void Create()
    {
        if (_pass == null)
        {
            _pass = new ShaderToyPass();
        }
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (_pass != null)
        {
            _pass.Setup(shaderToyAsset, drawToScreen, renderer.cameraColorTarget, finalTextureName,textureScale,useScreenMouse);

            renderer.EnqueuePass(_pass);
        }
    }
}


public static class Extensions
{
    public static void Clear(this RenderTexture rt, Color color)
    {
        var old = RenderTexture.active;
        RenderTexture.active = rt;
        if (rt)
        {
            GL.Clear(true, true, color);
        }

        RenderTexture.active = old;
    }
}

public class ShaderToy
{
    public static int iUVMouse = Shader.PropertyToID("iUVMouse");

    public static int iMouse = Shader.PropertyToID("iMouse");
    public static int iFrame = Shader.PropertyToID("iFrame");
    public static int iDate = Shader.PropertyToID("iDate");
    public static int iSampleRate = Shader.PropertyToID("iSampleRate");
    public static int iChannel0 = Shader.PropertyToID("iChannel0");
    public static int iChannel1 = Shader.PropertyToID("iChannel1");
    public static int iChannel2 = Shader.PropertyToID("iChannel2");
    public static int iChannel3 = Shader.PropertyToID("iChannel3");
}