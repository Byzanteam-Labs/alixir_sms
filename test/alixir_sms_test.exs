defmodule Alixir.SmsTest do
  use ExUnit.Case
  doctest Alixir.Sms

  test "greets the world" do
    assert Alixir.Sms.hello() == :world
  end
end
