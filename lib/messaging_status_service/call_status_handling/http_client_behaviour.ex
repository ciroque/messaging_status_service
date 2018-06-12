defmodule MessagingStatusService.CallStatusHandling.HttpClientBehaviour do
  @type url_t :: binary
  @type headers_t :: [{atom, binary}] | [{binary, binary}] | %{binary => binary}
  @type options_t :: Keyword.t()

  @callback get(url_t, headers_t, options_t) :: any()
end
