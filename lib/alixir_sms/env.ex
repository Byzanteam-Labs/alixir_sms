defmodule Alixir.SMS.Env do
  def format do
    Application.get_env(:alixir_sms, :format, "JSON")
  end

  def region_id do
    Process.get(:alixir_sms_region_id) ||
      Application.get_env(:alixir_sms, :region_id, "cn-hangzhou")
  end

  def access_key_id do
    Process.get(:alixir_sms_access_key_id) ||
      Application.get_env(:alixir_sms, :access_key_id)
  end

  def access_secret do
    Process.get(:alixir_sms_access_secret) ||
      Application.get_env(:alixir_sms, :access_secret)
  end

  @spec set_envs_in_process(assignments :: [{atom(), term()}]) :: :ok
  def set_envs_in_process(assignments) when is_list(assignments) do
    Enum.each(assignments, fn
      {_key, nil} ->
        :ok

      {_key, ""} ->
        :ok

      {key, value} ->
        "alixir_sms_#{key}"
        |> String.to_existing_atom()
        |> Process.put(value)
    end)
  end
end
