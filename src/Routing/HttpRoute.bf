using System;
using System.Collections;
using Chef.Core.Http;
using Chef.Logging;
using TinyRegex;

namespace Chef.Routing
{
	public class HttpRoute
	{
		public String RegisteredUrl { get; set => RegisteredUrl.Set(value); } = new .() ~ delete _;
		public String Url { get; set => Url.Set(value); } = new .() ~ delete _;
		public HttpRequest Request { get; set; }

		// The keys are destroyed when _parametersNames is destroyed
		public Dictionary<String, String> Parameters { get; private set; } = new .() ~ DeleteDictionaryAndValues!(_);

		private List<(int urlPosition, String name)> _parametersNames { get; private set; } = new .() ~ delete _;
		private String _compiledRegex = new .() ~ delete _;

		public this(StringView url)
		{
			RegisteredUrl.Set(url);
			CompileRegex();
		}

		public ~this()
		{
			for (let pair in _parametersNames)
			{
				delete pair.name;
			}
		}

		public bool Match(StringView url)
		{
			if (Regex.IsMatch(_compiledRegex, url))
			{
				GetParametersValues(url);
				ConsoleLogger.Debug("Route matched");
				return true;
			}
			return false;
		}

		private void CompileRegex()
		{
			_compiledRegex.Set(RegisteredUrl);
			_compiledRegex.Insert(0, '^');

			var parameterCount = 0;
			for (var i = 0; i < RegisteredUrl.Length; i++)
			{
				let char = RegisteredUrl[i];

				if (char == '{')
				{
					let paramName = RegisterParamName(i, parameterCount, ..scope String());

					_compiledRegex.Replace(scope $"{{{paramName}}}", @"[\w-_]+");

					i += 6;
					parameterCount++;
				}
			}

			_compiledRegex.Replace("/", @"\/");
			_compiledRegex.Insert(_compiledRegex.Length, '$');
		}

		private void RegisterParamName(int start, int parameterCount, String name)
		{
			let end = RegisteredUrl.IndexOf('}', start);
			let paramName = new String(RegisteredUrl.Substring(start + 1, end - start - 1));

			_parametersNames.Add((start - 1, paramName));
			Parameters.Add(paramName, new String());

			name.Set(paramName);
		}

		private void GetParametersValues(StringView url)
		{
			var endOfParameterName = -1;

			for (var pair in _parametersNames)
			{
				if (endOfParameterName != -1)
				{
					pair.urlPosition = endOfParameterName;
				}

				endOfParameterName = url.IndexOf('/', pair.urlPosition + 1);

				var length = 0;

				if (endOfParameterName == -1)
				{
					let lastChar = url.Length - 1;
					length = lastChar - pair.urlPosition;
				}
				else
				{
					length = endOfParameterName - (pair.urlPosition + 1);
				}

				let paramValue = url.Substring(pair.urlPosition + 1, length);

				Parameters[pair.name].Set(paramValue);
			}
		}
	}
}
