using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Threading.Tasks;
using EmbedIO;
using EmbedIO.Routing;
using EmbedIO.WebApi;

namespace EventsController
{
    public class WirecastController: WebApiController
    {
        [Route(HttpVerbs.Get, "/take")]
        public Dictionary<string, object> Go()
        {
            WirecastAPI.Take();

            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/layer/{layer}/shot/{shot}/autolive/{autolive}")]
        public Dictionary<string, object> SetShotOnLayer(int layer, int shot, int autolive)
        {
            WirecastAPI.SetShotForLayer(layer, shot);
            if (autolive != 0)
            {
                WirecastAPI.Take();
            }
            
            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/shots/{shot1}/{shot2}/{shot3}/{shot4}/{shot5}/autolive/{autolive}")]
        public Dictionary<string, object> SetShotsOnAllLayers(int shot1, int shot2, int shot3, int shot4, int shot5,
            int autolive)
        {
            WirecastAPI.SetShotForLayer(1, shot1);
            WirecastAPI.SetShotForLayer(2, shot2);
            WirecastAPI.SetShotForLayer(3, shot3);
            WirecastAPI.SetShotForLayer(4, shot4);
            WirecastAPI.SetShotForLayer(5, shot5);

            if (autolive != 0)
            {
                WirecastAPI.Take();
            }

            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/start-recording")]
        public Dictionary<string, object> StartRecording()
        {
            WirecastAPI.StartRecording();
            
            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/stop-recording")]
        public Dictionary<string, object> StopRecording()
        {
            WirecastAPI.StopRecording();
            
            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/start-broadcasting")]
        public Dictionary<string, object> StartBroadcasting()
        {
            WirecastAPI.StartBroadcasting();
            
            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }

        [Route(HttpVerbs.Get, "/stop-broadcasting")]
        public Dictionary<string, object> StopBroadcasting()
        {
            WirecastAPI.StopBroadcasting();
            
            return new Dictionary<string, object>
            {
                ["ok"] = true,
            };
        }
        
    }
}