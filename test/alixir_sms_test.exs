defmodule AlixirSmsTest do
  use ExUnit.Case
  doctest AlixirSms

  test "greets the world" do
    assert AlixirSms.hello() == :world
  end
end
