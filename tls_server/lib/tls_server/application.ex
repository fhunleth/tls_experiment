defmodule TLSServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [
      port: 4001,
      otp_app: :tls_server,
      keyfile: "priv/server-key.pem",
      certfile: "priv/server.pem",
      verify: :verify_peer,
      cacertfile: "priv/signer.pem"
    ]

    children = [
      Plug.Cowboy.child_spec(scheme: :https, plug: TLSServer.Router, options: opts)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TLSServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
