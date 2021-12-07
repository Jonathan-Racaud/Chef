using System;
using System.Collections;
using Chef.Logging;
using System.Net;

namespace Chef.Server
{
	public abstract class Server
	{
		public String Host { get; set => Host.Set(value); } = new .() ~ delete _;
		public int Port { get; set; }

		protected bool IsRunning = false;
		protected Dictionary<LogLevel, List<ILogger>> Loggers = new .() ~ DeleteDictionaryAndValues!(_);

		public void AddLogger(ILogger logger, LogLevel level = .Info)
		{
			if (level == .Any)
			{
				AddLogger(logger, .Debug);
				AddLogger(logger, .Info);
				AddLogger(logger, .Warn);
				AddLogger(logger, .Error);
				AddLogger(logger, .Fatal);
			}

			if (!Loggers.ContainsKey(level))
			{
				Loggers.Add(level, new List<ILogger>() { logger });
			}
			else
			{
				Loggers[level].Add(logger);
			}
		}

		public void UsingDefaultLogger(LogLevel level = .Any)
		{
			AddLogger(ConsoleLogger, level);
		}

		public void UsingDefaultLogger(params LogLevel[] levels)
		{
			for (let level in levels)
			{
				UsingDefaultLogger(level);
			}
		}

		public abstract void Start();
		protected abstract void HandleConnection();
		protected abstract void HandleRequest(Socket client, void* data, int dataSize, String response);

		protected virtual void Log(LogLevel level, StringView message)
		{
			switch (level)
			{
			case .Debug:
				for (let logger in Loggers[level]) logger.Debug(message);
			case .Warn:
				for (let logger in Loggers[level]) logger.Warn(message);
			case .Error:
				for (let logger in Loggers[level]) logger.Error(message);
			case .Fatal:
				for (let logger in Loggers[level]) logger.Fatal(message);
			case .Info, default:
				for (let logger in Loggers[level]) logger.Info(message);
			}
		}
	}
}
