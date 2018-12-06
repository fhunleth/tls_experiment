defmodule TlsServerTest do
  use ExUnit.Case
  doctest TlsServer

  test "greets the world" do
    assert TlsServer.hello() == :world
  end
end
