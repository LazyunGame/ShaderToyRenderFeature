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

    [Range(0.1f, 1)] public float textureScale = 1;


    public string finalTextureName = "_ShaderToyFinalTexture";


    private ShaderToyPass _renderPass;
    private DrawToScreenPass _drawToScreenPass;


    public override void Create()
    {
        if (_renderPass == null)
        {
            _renderPass = new ShaderToyPass();
        }

        if (drawToScreen && _drawToScreenPass == null)
        {
            _drawToScreenPass = new DrawToScreenPass();
        }
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (_renderPass != null)
        {
            _renderPass.Setup(shaderToyAsset, finalTextureName, textureScale, useScreenMouse);

            renderer.EnqueuePass(_renderPass);
        }

        if (_drawToScreenPass != null)
        {
            _drawToScreenPass.Setup(shaderToyAsset, drawToScreen, renderer.cameraColorTarget);
            renderer.EnqueuePass(_drawToScreenPass);
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