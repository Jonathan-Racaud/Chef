using System;

namespace Chef.Logging
{
	public class ConsoleLogger: ILogger
	{
		private ConsoleColor _defaultForegroundColor;

		public this()
		{
			_defaultForegroundColor = Console.ForegroundColor;
		}

		public void Info(System.StringView message)
		{
			Console.ForegroundColor = .Cyan;
			Console.WriteLine(scope $"[INFO]: {message}");
			Console.ForegroundColor = _defaultForegroundColor;
		}

		public void Debug(System.StringView message)
		{
			Console.ForegroundColor = .Green;
			Console.WriteLine(scope $"[DEBUG]: {message}");
			Console.ForegroundColor = _defaultForegroundColor;
		}

		public void Warn(System.StringView message)
		{
			Console.ForegroundColor = .Yellow;
			Console.WriteLine(scope $"[WARN]: {message}");
			Console.ForegroundColor = _defaultForegroundColor;
		}

		public void Error(System.StringView message)
		{
			Console.ForegroundColor = .Red;
			Console.WriteLine(scope $"[ERROR]: {message}");
			Console.ForegroundColor = _defaultForegroundColor;
		}

		public void Fatal(System.StringView message)
		{
			Console.ForegroundColor = .Magenta;
			Console.WriteLine(scope $"[FATAL]: {message}");
			Console.ForegroundColor = _defaultForegroundColor;
		}
	}

	static
	{
		public static ConsoleLogger ConsoleLogger = new ConsoleLogger();
	}
}
