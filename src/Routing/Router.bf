using System;
using System.Collections;
using Chef.Core;
using Chef.Core.Http;
using Chef.Logging;

namespace Chef.Routing
{
	public class Router: IRouter
	{
		public Dictionary<Route, RouteDelegate> GetRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<Route, RouteDelegate> PostRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<Route, RouteDelegate> PutRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<Route, RouteDelegate> DeleteRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);

		public void Map(HttpMethod method, StringView routeStr, RouteDelegate action)
		{
			let route = new Route(routeStr);

			switch (method)
			{
			case .Get:
				GetRoutes.Add(route, action);
			case .Post:
				PostRoutes.Add(route, action);
			case .Put:
				PutRoutes.Add(route, action);
			case .Delete:
				DeleteRoutes.Add(route, action);
			default:
				return;
			}
		}

		public void Handle(HttpRequest httpRequest, String response)
		{
			switch (httpRequest.Method)
			{
			case .Get:
				HandleRoute(GetRoutes, httpRequest, response);
			case .Post:
				HandleRoute(PostRoutes, httpRequest, response);
			case .Put:
				HandleRoute(PutRoutes, httpRequest, response);
			case .Delete:
				HandleRoute(DeleteRoutes, httpRequest, response);
			default:
				return;
			}
		}

		private void HandleRoute(Dictionary<Route, RouteDelegate> routes, HttpRequest httpRequest, String response)
		{
			let httpResponse = scope HttpResponse();

			for (let route in routes)
			{
				if (route.key.Match(httpRequest.Url))
				{
					route.value(route.key, httpResponse);
					response.Set(httpResponse.Build(..scope String()));
					return;
				}
			}

			httpResponse.Content = HttpStatus.NotFound.HtmlResponse(..scope String());
			response.Set(httpResponse.Build(..scope String()));
		}
	}
}
