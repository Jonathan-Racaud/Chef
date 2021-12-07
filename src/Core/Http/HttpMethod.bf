using System;

namespace Chef.Core.Http
{
	public enum HttpMethod
	{
		case Unknown;
		case Connect;
		case Delete;
		case Get;
		case Head;
		case Options;
		case Post;
		case Put;

		public void ToString(String method)
		{
			switch (this)
			{
			case .Connect:
				method.Set("CONNECT");
			case .Delete:
				method.Set("DELETE");
			case .Get:
				method.Set("GET");
			case .Head:
				method.Set("HEAD");
			case .Options:
				method.Set("OPTIONS");
			case .Post:
				method.Set("POST");
			case .Put:
				method.Set("PUT");
			case .Unknown:
				method.Set("Unknown");
			default:
				method.Set("Unknown");
			}
		}

		public static HttpMethod From(String str)
		{
			let temp = str;
			temp.ToLower();

			if (str.Equals("connect"))
				return .Connect;
			else if (str.Equals("delete"))
				return .Delete;
			else if (str.Equals("get"))
				return .Get;
			else if (str.Equals("head"))
				return .Head;
			else if (str.Equals("options"))
				return .Options;
			else if (str.Equals("post"))
				return .Post;
			else if (str.Equals("put"))
				return .Put;

			return .Unknown;
		}

		public static HttpMethod From(StringView str)
		{
			let newStr = new String(str);
			defer delete newStr;

			return From(newStr);
		}	
	}
}
