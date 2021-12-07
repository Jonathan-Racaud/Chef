using System;
using Chef.Core;
using Chef.Core.Http;

namespace Chef.Routing
{
	typealias HttpRouteDelegate = delegate void(HttpRoute, HttpResponse);

	public interface IHttpRouter
	{
		public void Map(HttpMethod method, StringView route, HttpRouteDelegate action);
		public void Handle(HttpRequest httpRequest, String response);

		public IHttpRouter Get(StringView route, HttpRouteDelegate action);
		public IHttpRouter Post(StringView route, HttpRouteDelegate action);
		public IHttpRouter Put(StringView route, HttpRouteDelegate action);
		public IHttpRouter Delete(StringView route, HttpRouteDelegate action);
	}
}
