using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;

namespace EventsController
{
    public static class WirecastAPI
    {
        private static object GetApplication()
        {
            try
            {
                object wirecast = Marshal.GetActiveObject("Wirecast.Application");
                return wirecast;
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public static void SetShotForLayer(int layer, int shot)
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            var layerObject = Late.Invoke(document, "LayerByIndex", layer);
            var shotId = Late.Invoke(layerObject, "ShotIDByIndex", shot);
            Late.Set(layerObject, "ActiveShotID", shotId);
        }

        public static void Take()
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            var layers = new[] {1, 2, 3, 4, 5};
            foreach (var layerId in layers)
            {
                var layer = Late.Invoke(document, "LayerByIndex", layerId);
                Late.Invoke(layer, "Go");
            }
        }

        public static void StartRecording()
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            
            Late.Invoke(document, "ArchiveToDisk", "start");
        }
        
        public static void StopRecording()
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            
            Late.Invoke(document, "ArchiveToDisk", "stop");
        }
        
        public static void StartBroadcasting()
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            
            Late.Invoke(document, "Broadcast", "start");
        }
        
        public static void StopBroadcasting()
        {
            var wirecast = GetApplication();
            var document = Late.Invoke(wirecast, "DocumentByIndex", 1);
            
            Late.Invoke(document, "Broadcast", "stop");
        }
    }
}