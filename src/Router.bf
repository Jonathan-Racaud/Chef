using System;
using System.Collections;
using Chef.Core;

namespace Chef
{
	typealias RouteDelegate = delegate void(HttpRequest, HttpResponse);

	public class Router
	{
		public Dictionary<String, RouteDelegate> GetRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<String, RouteDelegate> PostRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<String, RouteDelegate> PutRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<String, RouteDelegate> DeleteRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);

		public void Map(HttpMethod method, StringView route, RouteDelegate action)
		{
			switch (method)
			{
			case .Get:
				GetRoutes.Add(new String(route), action);
			case .Post:
				PostRoutes.Add(new String(route), action);
			case .Put:
				PutRoutes.Add(new String(route), action);
			case .Delete:
				DeleteRoutes.Add(new String(route), action);
			default:
				return;
			}
		}

		public void Handle(HttpRequest httpRequest, String response)
		{
			switch (httpRequest.Method)
			{
			case .Get:
				HandleGetRoute(httpRequest, response);
			case .Post:
				HandlePostRoute(httpRequest, response);
			case .Put:
				HandlePutRoute(httpRequest, response);
			case .Delete:
				HandleDeleteRoute(httpRequest, response);
			default:
				return;
			}
		}

		private void HandleGetRoute(HttpRequest httpRequest, String response)
		{
			let httpResponse = scope HttpResponse();

			if (!GetRoutes.ContainsKey(httpRequest.Url))
			{
				httpResponse.Content = HttpStatus.NotFound.HtmlResponse(..scope String());
			}
			else
			{
				GetRoutes[httpRequest.Url](httpRequest, httpResponse);
			}


			response.Set(httpResponse.Build(..scope String()));
		}

		private void HandlePostRoute(HttpRequest httpRequest, String response)
		{
			let httpResponse = scope HttpResponse();

			if (!PostRoutes.ContainsKey(httpRequest.Url))
			{
				httpResponse.Content = HttpStatus.NotFound.HtmlResponse(..scope String());
			}
			else
			{
				PostRoutes[httpRequest.Url](httpRequest, httpResponse);
			}

			response.Set(httpResponse.Build(..scope String()));
		}

		private void HandlePutRoute(HttpRequest httpRequest, String response)
		{
			let httpResponse = scope HttpResponse();

			if (!PutRoutes.ContainsKey(httpRequest.Url))
			{
				httpResponse.Content = HttpStatus.NotFound.HtmlResponse(..scope String());
			}
			else
			{
				PutRoutes[httpRequest.Url](httpRequest, httpResponse);
			}

			response.Set(httpResponse.Build(..scope String()));
		}

		private void HandleDeleteRoute(HttpRequest httpRequest, String response)
		{
			let httpResponse = scope HttpResponse();

			if (!DeleteRoutes.ContainsKey(httpRequest.Url))
			{
				httpResponse.Content = HttpStatus.NotFound.HtmlResponse(..scope String());
			}
			else
			{
				DeleteRoutes[httpRequest.Url](httpRequest, httpResponse);
			}

			response.Set(httpResponse.Build(..scope String()));
		}
	}
}
