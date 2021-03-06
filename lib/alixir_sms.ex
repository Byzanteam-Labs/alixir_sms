defmodule Alixir.SMS do
  @moduledoc """
  `Alixir.SMS` enables sms service for Aliyun.

  ## Examples

  ```
  operation = Alixir.SMS.send_sms("15000000000", "云通信", "SMS_0000", %{code: "1234", product: "ytx"}, "abcdefg")
  Alixir.request(operation)
  ```
  """

  alias Alixir.SMS.SendSMSOperation

  @type options :: [
          region_id: String.t(),
          access_key_id: String.t(),
          access_secret: String.t()
        ]

  @doc """
  Construct a Send SMS operation.

  Return an `Alixir.SMS.SendSMSOperation` struct which could be passed to `Alixir.request` to perform the request.

  ## Example

      iex> Alixir.SMS.send_sms("15000000000", "云通信", "SMS_0000", %{code: "1234", product: "ytx"}, "abcdefg")
      %Alixir.SMS.SendSMSOperation{
        http_method: :get,
        phone_numbers: "15000000000",
        sign_name: "云通信",
        template_code: "SMS_0000",
        template_param: %{code: "1234", product: "ytx"},
        out_id: "abcdefg"
      }

  """
  @spec send_sms(
          String.t() | nonempty_list(String.t()),
          String.t(),
          String.t(),
          map(),
          String.t(),
          options()
        ) :: %Alixir.SMS.SendSMSOperation{http_method: :get}
  def send_sms(
        phone_numbers,
        sign_name,
        template_code,
        template_param \\ %{},
        out_id \\ "",
        options \\ []
      ) do
    Alixir.SMS.Env.set_envs_in_process(
      Keyword.take(options, [
        :region_id,
        :access_key_id,
        :access_secret
      ])
    )

    %SendSMSOperation{
      http_method: :get,
      phone_numbers: phone_numbers,
      sign_name: sign_name,
      template_code: template_code,
      template_param: template_param,
      out_id: out_id
    }
  end
end
