defmodule MessagingStatusService.Calls.ErrorSinkBehaviour do
  @type message :: IO.chardata() | String.Chars.t()
  @type metadata :: keyword(String.Chars.t())
  @type message_t :: (() -> message) | {message, keyword}
  @callback error(message_t) :: any()
  @callback error(message_t, metadata) :: any()
end
