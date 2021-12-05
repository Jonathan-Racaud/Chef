using System;

namespace Chef.Logging
{
	public interface ILogger
	{
		public void Info(StringView message);
		public void Debug(StringView message);
		public void Warn(StringView message);
		public void Error(StringView message);
		public void Fatal(StringView message);
	}
}
