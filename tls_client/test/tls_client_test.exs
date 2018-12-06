defmodule TlsClientTest do
  use ExUnit.Case
  doctest TlsClient

  test "greets the world" do
    assert TlsClient.hello() == :world
  end
end
