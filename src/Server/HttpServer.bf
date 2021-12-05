using System;
using System.Net;
using Chef.Core;

namespace Chef.Server
{
	public class HttpServer: TcpServer
	{
		public Router Router { get; private set; } = new .() ~ delete _;

		protected override void HandleRequest(Socket client, void* data, int dataSize, String response)
		{
			let rawRequest = new String((char8*)data, dataSize);
			defer delete rawRequest;

			let request = scope HttpRequest();
			request.Parse(rawRequest);

#if DEBUG
			LogRequest(request);
#endif

			Router.Handle(request, response);
		}

#if DEBUG
		private void LogRequest(HttpRequest request)
		{
			Log(.Debug, scope $"Received request:");
			Log(.Debug, scope $"Method: {request.Method.ToString(..scope String())}");
			Log(.Debug, scope $"Url: {request.Url}");
			Log(.Debug, scope $"Protocol: {request.Protocol}");
			Log(.Debug, "Headers:");
			for (let header in request.Headers)
			{
				Log(.Debug, scope $"Key: {header.Key}, Value: {header.Value}");
			}
		}
#endif
	}
}
