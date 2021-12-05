using System;
using System.Collections;
using Chef.Logging;
using System.Net;

namespace Chef.Server
{
	public interface IServer
	{
		public String Host { get; set; }
		public int Port { get; set; }
	}

	public abstract class Server
	{
		private String _host = new .() ~ delete _;
		public String Host
		{
			get => _host;
			set => _host.Set(value);
		}

		public int Port { get; set; }

		protected bool IsRunning = false;
		protected Dictionary<LogLevel, List<ILogger>> Loggers = new .() ~ DeleteDictionaryAndValues!(_);

		public virtual void AddLogger(ILogger logger, LogLevel level = .Info)
		{
			if (level == .Any)
			{
				AddLogger(logger, .Info);
				AddLogger(logger, .Debug);
				AddLogger(logger, .Warn);
				AddLogger(logger, .Error);
				AddLogger(logger, .Fatal);
				return;
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
