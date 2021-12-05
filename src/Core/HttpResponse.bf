using System;
using System.Collections;

namespace Chef.Core
{
	public class HttpResponse
	{
		public HttpStatus Status;

		private String _content = new .() ~ delete _;
		public String Content
		{
			get => _content;
			set => _content.Set(value);
		}

		public String Protocol = new .() ~ delete _;

		public List<HttpHeader> Headers { get; private set; } = new .() ~ DeleteContainerAndItems!(_);

		public this()
		{
			Protocol.Set("HTTP/1.1");
		}

		public void Build(String response)
		{
			response.Clear();
			response.Append(scope $"{Protocol} {Status.Underlying} {Status.ToString(..scope String())}\r\n");
			response.Append(scope $"Server: Chef\r\n");

			for (let header in Headers)
			{
				response.Append(scope $"{header.Key}: {header.Value}");
			}

			response.Append(scope $"\r\n");

			response.Append(Content);
		}
	}
}
