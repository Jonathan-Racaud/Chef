using System;
using System.Collections;
using Chef.Core;
using Chef.Core.Http;
using Chef.Logging;

namespace Chef.Routing
{
	public class HttpRouter: IHttpRouter
	{
		public Dictionary<HttpRoute, HttpRouteDelegate> GetRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<HttpRoute, HttpRouteDelegate> PostRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<HttpRoute, HttpRouteDelegate> PutRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);
		public Dictionary<HttpRoute, HttpRouteDelegate> DeleteRoutes { get; private set; } = new .() ~ DeleteDictionaryAndKeysAndValues!(_);

		public void Map(HttpMethod method, StringView routeStr, HttpRouteDelegate action)
		{
			let route = new HttpRoute(routeStr);

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

		private void HandleRoute(Dictionary<HttpRoute, HttpRouteDelegate> routes, HttpRequest httpRequest, String response)
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

		public IHttpRouter Get(StringView route, HttpRouteDelegate action)
		{
			Map(.Get, route, action);

			return this;
		}

		public IHttpRouter Post(StringView route, HttpRouteDelegate action)
		{
			Map(.Post, route, action);

			return this;
		}

		public IHttpRouter Put(StringView route, HttpRouteDelegate action)
		{
			Map(.Put, route, action);

			return this;
		}

		public IHttpRouter Delete(StringView route, HttpRouteDelegate action)
		{
			Map(.Delete, route, action);

			return this;
		}
	}
}
