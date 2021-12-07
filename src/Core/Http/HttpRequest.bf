using System;
using System.Collections;

namespace Chef.Core.Http
{
	public class HttpRequest
	{
		public String Protocol { get; private set; } = new .() ~ delete _;
		public HttpMethod Method { get; private set; }
		public String Url { get; private set; } = new .() ~ delete _;
		public String QueryString { get; private set; } = new .() ~ delete _;
		public List<HttpHeader> Headers { get; private set; } = new .() ~ DeleteContainerAndItems!(_);
		public HttpBody Body { get; private set; } = new .() ~ delete _;

		public void Parse(StringView rawRequest)
		{
			let request = new String(rawRequest);
			defer delete request;

			var lines = request.Split("\r\n");
			defer { DeleteContainerAndItems!(lines); }

			ParseRequest(lines[0]);
			lines.DeleteAt(0);

			let lineCount = ParseHeaders(lines);
			if (lineCount != 0)
			{
				lines.DeleteRange(0, lineCount);
			}

			switch (Method)
			{
			case .Options, .Post, .Put:
				ParseBody(lines);
			default:
			}
		}

		private void ParseRequest(String line)
		{
			var tokens = line.Split(" ");
			defer { DeleteContainerAndItems!(tokens); }

			Method = HttpMethod.From(tokens[0]);

			let tempUrl = tokens[1];
			ParseQueryString(tempUrl);

			if (!QueryString.IsEmpty)
			{
				let queryIndex = tempUrl.IndexOf(QueryString);

				Url.Set(tempUrl.Substring(0, queryIndex));
			}
			else
			{
				Url.Set(tempUrl);
			}

			Protocol.Set(tokens[2]);
		}

		private void ParseQueryString(String url)
		{
			if (!url.Contains('?'))
				return;

			let index = url.IndexOf('?');
			QueryString.Set(url.Substring(index));
		}

		private int ParseHeaders(List<String> lines)
		{
			var lineCount = 0;

			for (let headerLine in lines)
			{
				var tokens = headerLine.Split(":", 1);
				defer { DeleteContainerAndItems!(tokens); }

				if (tokens.Count == 0)
					break;

				let key = tokens[0];
				let value = tokens[1];
				value.TrimStart();

				Headers.Add(new HttpHeader(key, value));

				lineCount += 1;
				if (headerLine.Equals("\r\n") || headerLine.IsEmpty)
				{
					break;
				}	
			}

			return lineCount;
		}

		private void ParseBody(List<String> lines)
		{
			for (let line in lines)
			{
				Body.Raw.Append(line);
			}	
		}
	}
}
