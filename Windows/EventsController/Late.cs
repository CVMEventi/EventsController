using System.Reflection;

namespace EventsController
{
    /// <summary>
        /// Late binding helper class.
        /// static bindings to help you get/set via OLE/COM.
        /// </summary>
        static class Late
        {
            public static void Set(object obj, string sProperty, object oValue)
            {
                object[] oParam = new object[1];
                oParam[0] = oValue;
                obj.GetType().InvokeMember(sProperty, BindingFlags.SetProperty, null, obj, oParam);
            }
            public static object Get(object obj, string sProperty, object oValue)
            {
                object[] oParam = new object[1];
                oParam[0] = oValue;
                return obj.GetType().InvokeMember(sProperty, BindingFlags.GetProperty, null, obj, oParam);
            }
            public static object Get(object obj, string sProperty, object[] oValue)
            {
                return obj.GetType().InvokeMember(sProperty, BindingFlags.GetProperty, null, obj, oValue);
            }
            public static object Get(object obj, string sProperty)
            {
                return obj.GetType().InvokeMember(sProperty, BindingFlags.GetProperty, null, obj, null);
            }
            public static object Invoke(object obj, string sProperty, object[] oParam)
            {
                return obj.GetType().InvokeMember(sProperty, BindingFlags.InvokeMethod, null, obj, oParam);
            }
            public static object Invoke(object obj, string sProperty, object oValue)
            {
                object[] oParam = new object[1];
                oParam[0] = oValue;
                return obj.GetType().InvokeMember(sProperty, BindingFlags.InvokeMethod, null, obj, oParam);
            }
            public static object Invoke(object obj, string sProperty, object oValue, object oValue2)
            {
                object[] oParam = new object[2];
                oParam[0] = oValue;
                oParam[1] = oValue2;
                return obj.GetType().InvokeMember(sProperty, BindingFlags.InvokeMethod, null, obj, oParam);
            }
            public static object Invoke(object obj, string sProperty)
            {
                return obj.GetType().InvokeMember(sProperty, BindingFlags.InvokeMethod, null, obj, null);
            }
        }
}