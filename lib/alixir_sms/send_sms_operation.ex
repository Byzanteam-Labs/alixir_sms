defmodule Alixir.SMS.SendSMSOperation do
  @enforce_keys [:http_method, :phone_numbers, :sign_name, :template_code]
  defstruct [
    :http_method,
    :phone_numbers,
    :sign_name,
    :template_code,
    :template_param,
    :out_id
  ]

  alias Alixir.SMS.Utils
  alias Alixir.SMS.SendSMSOperation

  defimpl Alixir.Request.Operation do
    def perform(%SendSMSOperation{http_method: http_method} = operation) do
      query_str = Utils.make_query_string(operation)
      signature = Utils.make_signature(http_method, query_str)

      url = Utils.make_request_url(signature, query_str)

      %Alixir.Request{
        http_method: http_method,
        url: url
      }
    end
  end
end
