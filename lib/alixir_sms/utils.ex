defmodule Alixir.SMS.Utils do
  alias Alixir.SMS.Env
  import Alixir.Utils

  @joiner "&"
  @endpoint "http://dysmsapi.aliyuncs.com"

  def make_request_url(signature, query_str) do
    "#{@endpoint}?Signature=#{url_encode(signature, :pop)}#{@joiner}#{query_str}"
  end

  def make_query_string(operation) do
    operation
    |> build_send_sms_params()
    |> Map.merge(build_system_params())
    |> canonicalize_parameters()
  end

  def make_signature(http_method, query_str) do
    str_to_sign = http_method
                  |> to_string()
                  |> String.upcase()
                  |> fn method ->
                    method <> @joiner <> url_encode("/", :pop) <> @joiner <> url_encode(query_str, :pop)
                  end.()
    sign(Env.access_secret <> @joiner, str_to_sign)
  end

  def build_system_params do
    %{
      "SignatureMethod":  "HMAC-SHA1",
      "SignatureNonce":   to_string(:rand.uniform),
      "AccessKeyId":      Env.access_key_id(),
      "SignatureVersion": "1.0",
      "Timestamp":        gmt_now(),
      "Format":           Env.format(),
    }
  end

  def build_send_sms_params(operation) do
    %{
      "Action":        "SendSms",
      "Version":       "2017-05-25",
      "RegionId":      Env.region_id(),
      "PhoneNumbers":  convert_phone_numbers(operation.phone_numbers),
      "SignName":      operation.sign_name,
      "TemplateCode":  operation.template_code,
      "TemplateParam": Poison.encode!(operation.template_param),
      "OutId":         operation.out_id,
    }
  end

  defp convert_phone_numbers(phone_numbers) when is_list(phone_numbers) do
    Enum.join(phone_numbers, ",")
  end
  defp convert_phone_numbers(phone_numbers), do: to_string(phone_numbers)

  def canonicalize_parameters(%{} = parameters) do
    parameters
    |> Enum.reduce(fn
      {_key, val}, acc when val == "" or val == nil ->
        acc
      {key, val}, acc ->
        ["#{url_encode(key, :pop)}=#{url_encode(val, :pop)}" | acc]
    end)
    |> Enum.sort()
    |> Enum.join(@joiner)
  end
end
