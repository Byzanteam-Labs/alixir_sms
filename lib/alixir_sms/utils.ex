defmodule Alixir.SMS.Utils do
  alias Alixir.SMS.Env
  import Alixir.Utils

  @joiner "&"
  @endpoint "http://dysmsapi.aliyuncs.com"

  def make_request_url(signature, query_str) do
    "#{@endpoint}/?Signature=#{url_encode(signature, :pop)}#{@joiner}#{query_str}"
  end

  def make_query_string(operation) do
    operation
    |> build_send_sms_params()
    |> Map.merge(build_system_params())
    |> canonicalize_parameters()
  end

  def make_signature(http_method, query_str) do
    str_to_sign =
      http_method
      |> to_string()
      |> String.upcase()
      |> (fn method ->
            method <> @joiner <> url_encode("/", :pop) <> @joiner <> url_encode(query_str, :pop)
          end).()

    sign(str_to_sign, Env.access_secret() <> @joiner)
  end

  def build_system_params do
    %{
      SignatureMethod: "HMAC-SHA1",
      SignatureNonce: uuid(),
      AccessKeyId: Env.access_key_id(),
      SignatureVersion: "1.0",
      Timestamp: iso_8601_extended_gmt_now(),
      Format: Env.format()
    }
  end

  def build_send_sms_params(operation) do
    %{
      Action: "SendSms",
      Version: "2017-05-25",
      RegionId: Env.region_id(),
      PhoneNumbers: convert_phone_numbers(operation.phone_numbers),
      SignName: operation.sign_name,
      TemplateCode: operation.template_code,
      TemplateParam: Jason.encode!(operation.template_param),
      OutId: operation.out_id
    }
  end

  defp convert_phone_numbers(phone_numbers) when is_list(phone_numbers) do
    Enum.join(phone_numbers, ",")
  end

  defp convert_phone_numbers(phone_numbers), do: to_string(phone_numbers)

  def canonicalize_parameters(%{} = parameters) do
    parameters
    |> Enum.sort(fn {key1, _}, {key2, _} -> to_string(key1) < to_string(key2) end)
    |> Stream.reject(fn {_key, val} -> val == "" or val == nil end)
    |> Stream.map(fn {key, val} ->
      "#{key |> to_string() |> url_encode(:pop)}=#{val |> to_string() |> url_encode(:pop)}"
    end)
    |> Enum.join(@joiner)
  end
end
