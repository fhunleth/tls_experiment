defmodule TLSClient.Client do
  def doit() do
    ssl_opts = [
      {:ssl_options,
       [
         keyfile: "priv/device-key.pem",
         certfile: "priv/device.pem",
         verify: :verify_peer,
         cacertfile: "priv/server.pem"
       ]}
    ]

    {:ok, _status, _headers, client_ref} = :hackney.request(:get, "https://localhost:4001/hello", [], <<>>, ssl_opts)
    :hackney.body(client_ref)
  end
end
