using Lazyun.Runtime;
using UnityEditor;
using UnityEngine;

namespace Lazyun
{
    [CustomEditor(typeof(ShaderToyAsset))]
    public class ShaderToyAssetInspector : Editor
    {
        private SerializedProperty bufferA, bufferB, bufferC, bufferD, image, mainMaterial;

        private void OnEnable()
        {
            bufferA = serializedObject.FindProperty("bufferA");
            bufferB = serializedObject.FindProperty("bufferB");
            bufferC = serializedObject.FindProperty("bufferC");
            bufferD = serializedObject.FindProperty("bufferD");
            image = serializedObject.FindProperty("image");

            mainMaterial = serializedObject.FindProperty("mainMaterial");
        }

        public override void OnInspectorGUI()
        {
            EditorGUILayout.PropertyField(mainMaterial);

            DrawBufferGUI(bufferA, ChannelEnum.bufferA);
            EditorGUILayout.Space();

            DrawBufferGUI(bufferB, ChannelEnum.bufferB);
            EditorGUILayout.Space();


            DrawBufferGUI(bufferC, ChannelEnum.bufferC);
            EditorGUILayout.Space();


            DrawBufferGUI(bufferD, ChannelEnum.bufferD);
            EditorGUILayout.Space();

            DrawBufferGUI(image, ChannelEnum.image);

            serializedObject.ApplyModifiedProperties();
        }

        void DrawBufferGUI(SerializedProperty buffer, ChannelEnum channelEnum)
        {
            EditorGUILayout.BeginVertical("box");

            if (buffer != null)
            {
                EditorGUILayout.LabelField(buffer.name.ToUpper().Replace("BUFFER", ""));
                var bufferNameProperty = buffer.FindPropertyRelative("bufferName");
                var bufferName = (ChannelEnum) bufferNameProperty.enumValueIndex;

                bool isEnable = EditorGUILayout.Toggle("Enabled:", bufferName == channelEnum);
                if (!isEnable)
                {
                    bufferNameProperty.enumValueIndex = (int) ChannelEnum.none;
                    EditorGUILayout.EndHorizontal();
                    return;
                }
                else
                {
                    bufferNameProperty.enumValueIndex = (int) channelEnum;
                }

                GUI.enabled = false;
                EditorGUILayout.PropertyField(bufferNameProperty);
                GUI.enabled = true;
                var inputBufferNamesProperty = buffer.FindPropertyRelative("inputBufferNames");
                EditorGUILayout.PropertyField(inputBufferNamesProperty);

                var material = buffer.FindPropertyRelative("material");
                EditorGUILayout.PropertyField(material);

                var formatProperty = buffer.FindPropertyRelative("format");
                EditorGUILayout.PropertyField(formatProperty);
                var sizeProperty = buffer.FindPropertyRelative("size");
                EditorGUILayout.PropertyField(sizeProperty);
                var filterTypeProperty = buffer.FindPropertyRelative("filterType");
                EditorGUILayout.PropertyField(filterTypeProperty);
                var wrapModeProperty = buffer.FindPropertyRelative("wrapMode");
                EditorGUILayout.PropertyField(wrapModeProperty);
            }

            EditorGUILayout.EndHorizontal();
        }
    }
}