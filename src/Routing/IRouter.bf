using System;
using Chef.Core;
using Chef.Core.Http;

namespace Chef.Routing
{
	typealias RouteDelegate = delegate void(Route, HttpResponse);

	public interface IRouter
	{
		public void Map(HttpMethod method, StringView route, RouteDelegate action);
		public void Handle(HttpRequest httpRequest, String response);
	}
}
