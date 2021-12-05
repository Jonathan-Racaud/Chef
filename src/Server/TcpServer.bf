using System;
using System.Collections;
using System.Net;
using Chef.Logging;
using System.Threading;
using System.Threading.Tasks;

namespace Chef.Server
{
	public abstract class TcpServer: Server
	{
		private Socket _socket = new .() ~ {
			delete _socket;
			Socket.Uninit();
		}

		private Dictionary<Task, Action> _connections = new .() ~ delete _;

		public this()
		{
			Socket.Init();
		}

		public ~this()
		{
			Socket.Uninit();
		}

		public override void Start()
		{
			if (_socket.Listen((int32)Port) case .Err)
			{
				Log(.Error, scope $"Couldn't listen to port: {Port}");
				return;
			}

			Log(.Info, scope $"Server listening on port: {Port}");

			IsRunning = true;

			Console.OnCancel.Add(scope (cancelKind, terminate) => {
				if (cancelKind == .CtrlC)
				{
					IsRunning = false;
				}
			});

			while (IsRunning)
			{
				HandleConnection();
			}
		}

		protected override void HandleConnection()
		{
			let client = scope Socket();

			if (client.AcceptFrom(_socket) case .Ok)
			{
				Thread.Sleep(1);
				let data = Internal.Malloc(1024);
				defer Internal.Free(data);

				if (client.Recv(data, 1024) case .Ok(let readSize))
				{
					if (readSize > 0)
					{
						let response = HandleRequest(client, data, readSize, ..new String());
						defer delete response;

#if DEBUG
						Log(.Debug, scope $"Sending response:\n{response}");
#endif

						if (client.Send(response.CStr(), response.Length) case .Err)
						{
							Log(.Error, scope $"Failed to send response to client");
						}
					}
				}
			}
		}
	}
}
