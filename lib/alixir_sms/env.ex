defmodule Alixir.SMS.Env do
  def format do
    Application.get_env(:alixir_sms, :format, "JSON")
  end

  def region_id do
    Process.get(:region_id) || Application.get_env(:alixir_sms, :region_id, "cn-hangzhou")
  end

  def access_key_id do
    Process.get(:access_key_id) || Application.get_env(:alixir_sms, :access_key_id)
  end

  def access_secret do
    Process.get(:access_secret) || Application.get_env(:alixir_sms, :access_secret)
  end
end
