defmodule Alixir.SMS.Env do
  def format do
    Application.get_env(:alixir_sms, :format, "JSON")
  end

  def region_id do
    Application.get_env(:alixir_sms, :region_id, "cn-hangzhou")
  end

  def access_key_id do
    Application.get_env(:alixir_sms, :access_key_id)
  end

  def access_secret do
    Application.get_env(:alixir_sms, :access_secret)
  end
end
