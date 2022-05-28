using System;
using System.Linq;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

#endif


namespace Lazyun.Runtime
{
    [System.AttributeUsage(System.AttributeTargets.Field)]
    public class EnumIntValue : PropertyAttribute
    {
        public readonly int[] values;

        public EnumIntValue(int[] values)
        {
            this.values = values;
        }
    }


    [CustomPropertyDrawer(typeof(EnumIntValue))]
    public class EnumOrderDrawer : PropertyDrawer
    {
        EnumIntValue enumValue
        {
            get { return ((EnumIntValue) attribute); }
        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            EditorGUI.BeginProperty(position, label, property);

            int[] indexArray = enumValue.values;

            // var items = indexArray.Select(t=>t.ToString()).ToArray();
            var items = Array.ConvertAll(indexArray, t => t.ToString());
            int index = Array.IndexOf(indexArray, property.intValue);

            // Display popup
            index = EditorGUI.Popup(
                position,
                label.text,
                index,
                items);
            property.intValue = indexArray[index];


            EditorGUI.EndProperty();
        }
    }
}