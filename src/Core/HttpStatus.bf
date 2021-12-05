using System;

namespace Chef.Core
{
	public enum HttpStatus
	{
		case Continue                = 100;
		case SwitchingProtocols      = 101;
		case Processing              = 102;
		case EarlyHints              = 103;

		case OK                      = 200;
		case Created                 = 201;
		case Accepted                = 202;
		case NonAuthInfo             = 203;
		case NoContent               = 204;
		case ResetContent            = 205;
		case PartialContent          = 206;
		case MultiStatus             = 207;
		case AlreadyReported         = 208;

		case MultipleChoices         = 300;
		case MovedPermanently        = 301;
		case Found                   = 302;
		case SeeOther                = 303;
		case NotModified             = 304;
		case UseProxy                = 305;
		case SwitchProxy             = 306;
		case TempRedirect            = 307;
		case PermRedirect            = 308;

		case BadRequest              = 400;
		case Unauthorized            = 401;
		case PaymentRequired         = 402;
		case Forbidden               = 403;
		case NotFound                = 404;
		case MethodNotAllowed        = 405;
		case NotAcceptable           = 406;
		case ProxyAuthRequired       = 407;
		case RequestTimeout          = 408;
		case Conflict                = 409;
		case Gone                    = 410;
		case LengthRequired          = 411;
		case PreconditionFailed      = 412;
		case PayloadTooLarge         = 413;
		case RequestTooLong          = 414;
		case UnsupportedMediaType    = 415;
		case RangeNotSatisfiable     = 416;
		case ExpectationsFailed      = 417;
		case ImATeapot               = 418;
		case MisdirectedRequest      = 421;
		case UnprocessableEntity     = 422;
		case Locked                  = 423;
		case FailedDependency        = 424;
		case TooEarly                = 425;
		case UpgradeRequired         = 426;
		case PreconditionRequired    = 428;
		case TooManyRequests         = 429;
		case ReqHdrFieldsTooLarge    = 431;
		case UnavailForLegalReasons  = 451;

		case InternalError           = 500;
		case NotImplemented          = 501;
		case BadGateway              = 502;
		case ServiceUnavailable      = 503;
		case GatewayTimeout          = 504;
		case HttpVersionNotSupported = 505;
		case VariantAlsoNegotiates   = 506;
		case InsufficientStorage     = 507;
		case LoopDetected            = 508;
		case NotExtended             = 510;
		case NetworkAuthRequired     = 511;

		public void HtmlResponse(String response)
		{
			switch (this)
			{
			case .BadRequest:
				response.Set("<html><head><title>400 Bad Request</title></head><body>\n<h1>Bad Request</h1>\n<p>The server cannot or will not process the request due to an apparent client error.</p>\n</body></html>\n");
			case .Unauthorized:
				response.Set("<html><head><title>401 Unauthorized</title></head><body>\n<h1>Unauthorized</h1>\n<p>You must provide valid credentials to access this resource.</p>\n</body></html>\n");
			case .PaymentRequired:
				response.Set("<html><head><title>402 Payment Required</title></head><body>\n<h1>Payment Required</h1>\n<p>Payment is required to use this service.</p>\n</body></html>\n");
			case .Forbidden:
				response.Set("<html><head><title>403 Forbidden</title></head><body>\n<h1>Forbidden</h1>\n<p>You do not have permission to access this resource.</p>\n</body></html>\n");
			case .NotFound:
				response.Set("<html><head><title>404 Not Found</title></head><body>\n<h1>Not Found</h1>\n<p>The requested URL was not found on this server.</p>\n</body></html>\n");
			case .MethodNotAllowed:
				response.Set("<html><head><title>405 Method Not Allowed</title></head><body>\n<h1>Method Not Allowed</h1>\n<p>A request method is not supported for the requested resource.</p>\n</body></html>\n");
			case .NotAcceptable:
				response.Set("<html><head><title>406 Not Acceptable</title></head><body>\n<h1>Not Acceptable</h1>\n<p>The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request.</p>\n</body></html>\n");
			case .ProxyAuthRequired:
				response.Set("<html><head><title>407 Proxy Authentication Required</title></head><body>\n<h1>Proxy Authentication Required</h1>\n<p>The client must first authenticate itself with the proxy.</p>\n</body></html>\n");
			case .RequestTimeout:
				response.Set("<html><head><title>408 Request Timeout</title></head><body>\n<h1>Request Timeout</h1>\n<p>The server timed out waiting for the request.</p>\n</body></html>\n");
			case .Conflict:
				response.Set("<html><head><title>409 Conflict</title></head><body>\n<h1>Conflict</h1>\n<p>Indicates that the request could not be processed because of conflict in the current state of the resource.</p>\n</body></html>\n");
			case .Gone:
				response.Set("<html><head><title>410 Gone</title></head><body>\n<h1>Gone</h1>\n<p>The requested resource is no longer available.</p>\n</body></html>\n");
			case .LengthRequired:
				response.Set("<html><head><title>411 Length Required</title></head><body>\n<h1>Length Required</h1>\n<p>The request did not specify the length of its content, which is required by the requested resource.</p>\n</body></html>\n");
			case .PreconditionFailed:
				response.Set("<html><head><title>412 Precondition Failed</title></head><body>\n<h1>Precondition Failed</h1>\n<p>The precondition on the request evaluated to false.</p>\n</body></html>\n");
			case .PayloadTooLarge:
				response.Set("<html><head><title>413 Payload Too Large</title></head><body>\n<h1>Payload Too Large</h1>\n<p>The request is larger than the server is willing or able to process.</p>\n</body></html>\n");
			case .RequestTooLong:
				response.Set("<html><head><title>414 Request Too Long</title></head><body>\n<h1>Bad Request</h1>\n<p>Your browser did a request that was too long for this server to parse.</p>\n</body></html>\n");
			case .UnsupportedMediaType:
				response.Set("<html><head><title>415 Unsupported Media Type</title></head><body>\n<h1>Unsupported Media Type</h1>\n<p>The request entity has a media type which the server or resource does not support.</p>\n</body></html>\n");
			case .RangeNotSatisfiable:
				response.Set("<html><head><title>416 Range Not Satisfiable</title></head><body>\n<h1>Range Not Satisfiable</h1>\n<p>The client has asked for a portion of the file, but the server cannot supply that portion.</p>\n</body></html>\n");
			case .ExpectationsFailed:
				response.Set("<html><head><title>417 Expectations Failed</title></head><body>\n<h1>Expectations Failed</h1>\n<p>The server cannot meet the requirements of the Expect request-header field.</p>\n</body></html>\n");
			case .ImATeapot:
				response.Set("<html><head><title>418 I'm A Teapot</title></head><body>\n<h1>I'm A Teapot</h1><br>\n<img src=\"data:image/png;base64,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\" alt=\"Teapot\" />\n</body></html>\n");
			case .MisdirectedRequest:
				response.Set("<html><head><title>421 Misdirected Request</title></head><body>\n<h1>Misdirected Request</h1>\n<p>The request was directed at a server that is not able to produce a response.</p>\n</body></html>\n");
			case .UnprocessableEntity:
				response.Set("<html><head><title>422 Unprocessable Entity</title></head><body>\n<h1>Unprocessable Entity</h1>\n<p>The request was well-formed but was unable to be followed due to semantic errors.</p>\n</body></html>\n");
			case .Locked:
				response.Set("<html><head><title>423 Locked</title></head><body>\n<h1>Locked</h1>\n<p>The resource that is being accessed is locked.</p>\n</body></html>\n");
			case .FailedDependency:
				response.Set("<html><head><title>424 Failed Dependency</title></head><body>\n<h1>Failed Dependency</h1>\n<p>The request failed because it depended on another request and that request failed.</p>\n</body></html>\n");
			case .TooEarly:
				response.Set("<html><head><title>425 Too Early</title></head><body>\n<h1>Too Early</h1>\n<p>Indicates that the server is unwilling to risk processing a request that might be replayed.</p>\n</body></html>\n");
			case .UpgradeRequired:
				response.Set("<html><head><title>426 Upgrade Required</title></head><body>\n<h1>Upgrade Required</h1>\n<p>The client should switch to a different protocol.</p>\n</body></html>\n");
			case .PreconditionRequired:
				response.Set("<html><head><title>428 Precondition Required</title></head><body>\n<h1>Precondition Required</h1>\n<p>The origin server requires the request to be conditional. Intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it, and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.</p>\n</body></html>\n");
			case .TooManyRequests:
				response.Set("<html><head><title>429 Too Many Requests</title></head><body>\n<h1>Too Many Requests</h1>\n<p>The user has sent too many requests in a given amount of time.</p>\n</body></html>\n");
			case .ReqHdrFieldsTooLarge:
				response.Set("<html><head><title>431 Request Header Fields Too Large</title></head><body>\n<h1>Request Header Fields Too Large</h1>\n<p>The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.</p>\n</body></html>\n");
			case .UnavailForLegalReasons:
				response.Set("<html><head><title>451 Unavailable For Legal Reasons</title></head><body>\n<h1>Unavailable For Legal Reasons</h1>\n<p>The server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource.</p>\n</body></html>\n");

			case .InternalError:
				response.Set("<html><head><title>500 Internal Server Error</title></head><body>\n<h1>Internal Server Error</h1>\n<p>An error occurred while generating the content for this request.</p>\n</body></html>\n");
			case .NotImplemented:
				response.Set("<html><head><title>501 Method Not Implemented</title></head><body>\n<h1>Method Not Implemented</h1>\n<p>The method used in the request is invalid.</p>\n</body></html>\n");
			case .BadGateway:
				response.Set("<html><head><title>502 Bad Gateway</title></head><body>\n<h1>Bad Gateway</h1>\n<p>The server was acting as a gateway or proxy and received an invalid response from the upstream server.</p>\n</body></html>\n");
			case .ServiceUnavailable:
				response.Set("<html><head><title>503 Service Unavailable</title></head><body>\n<h1>Service Unavailable</h1>\n<p>The server cannot handle the request (because it is overloaded or down for maintenance).</p>\n</body></html>\n");
			case .GatewayTimeout:
				response.Set("<html><head><title>504 Gateway Timeout</title></head><body>\n<h1>Gateway Timeout</h1>\n<p>The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.</p>\n</body></html>\n");
			case .HttpVersionNotSupported:
				response.Set("<html><head><title>505 HTTP Version Not Supported</title></head><body>\n<h1>HTTP Version Not Supported</h1>\n<p>The server does not support the HTTP protocol version used in the request.</p>\n</body></html>\n");
			case .VariantAlsoNegotiates:
				response.Set("<html><head><title>506 Variant Also Negotiates</title></head><body>\n<h1>Variant Also Negotiates</h1>\n<p>Transparent content negotiation for the request results in a circular reference.</p>\n</body></html>\n");
			case .InsufficientStorage:
				response.Set("<html><head><title>507 Insufficient Storage</title></head><body>\n<h1>Insufficient Storage</h1>\n<p>The server is unable to store the representation needed to complete the request.</p>\n</body></html>\n");
			case .LoopDetected:
				response.Set("<html><head><title>508 Loop Detected</title></head><body>\n<h1>Loop Detected</h1>\n<p>The server detected an infinite loop while processing the request.</p>\n</body></html>\n");
			case .NotExtended:
				response.Set("<html><head><title>510 Not Extended</title></head><body>\n<h1>Not Extended</h1>\n<p>Further extensions to the request are required for the server to fulfil it.</p>\n</body></html>\n");
			case .NetworkAuthRequired:
				response.Set("<html><head><title>511 Network Authentication Required</title></head><body>\n<h1>Network Authentication Required</h1>\n<p>The client needs to authenticate to gain network access.</p>\n</body></html>\n");
			default:
				response.Set("");
			}
		}
	}
}
