defmodule TLSServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def start_link do
    Plug.Adapters.Cowboy.http(Nerves.TestServer.Router, [])
  end

  get "/hello/*_" do
    conn
    |> send_resp(200, "Hello, world!")
  end

  match _ do
    conn
    |> send_resp(404, "Not Found")
    |> Plug.Conn.halt()
  end
end
