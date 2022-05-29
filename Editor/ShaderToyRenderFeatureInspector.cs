using UnityEditor;

namespace Lazyun
{
    [CustomEditor(typeof(ShaderToyRenderFeature))]
    public class ShaderToyRenderFeatureInspector : Editor
    {
        private SerializedProperty mainAsset, drawToScreen, 
            useScreenMouse, textureScale, finalTextureName;

        private void OnEnable()
        {
            mainAsset = serializedObject.FindProperty("shaderToyAsset");
            drawToScreen = serializedObject.FindProperty("drawToScreen");
            useScreenMouse = serializedObject.FindProperty("useScreenMouse");
            textureScale = serializedObject.FindProperty("textureScale");
            finalTextureName = serializedObject.FindProperty("finalTextureName");
        }

        public override void OnInspectorGUI()
        {
            EditorGUILayout.PropertyField(drawToScreen);
            EditorGUILayout.PropertyField(useScreenMouse);
            EditorGUILayout.PropertyField(textureScale);
            EditorGUILayout.PropertyField(finalTextureName);

            EditorGUILayout.PropertyField(mainAsset);
            if (mainAsset.objectReferenceValue)
            {
                var e = Editor.CreateEditor(mainAsset.objectReferenceValue);
                e.DrawDefaultInspector();
            }
        }
    }
}