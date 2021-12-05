using System;

namespace Chef.Core
{
	public class HttpHeader
	{
		public String Key { get; private set; } = new .() ~ delete _;
		public String Value { get; private set; } = new .() ~ delete _;

		public this(String key, String value = "")
		{
			Key.Set(key);
			Value.Set(value);
		}

		public this(StringView key, StringView value = "")
		{
			Key.Set(key);
			Value.Set(value);
		}

		public const String Connection = "Connection";
		public const String ContentLength = "Content-Length";
		public const String ContentType = "Content-Type";
		public const String Accept = "Accept";
		public const String AcceptCharset = "Accept-Charset";
		public const String AcceptEncoding = "Accept-Encoding";
		public const String AcceptLanguage = "Accept-Language";
		public const String Host = "Host";
		public const String From = "From";
		public const String Referer = "Referer";
		public const String UserAgent = "User-Agent";
		public const String Range = "Range";
		public const String TransferEncoding = "Transfert";
		public const String IfModifiedSince = "If-Modified-Since";
		public const String IfUnmodifiedSince = "If-Unmodified-Since";
		public const String Cookie = "Cookie";
		public const String XRequestedWidth = "X-Requested-Width";
		public const String Authorization = "Authorization";
	}
}
