defmodule MessagingStatusServiceWeb.Api.SmsController do
  use MessagingStatusServiceWeb, :controller

  require Logger

  @sms_completed_handler Application.get_env(:messaging_status_service, :calls)[:sms_completed_handler]
  @sms_response_redirect Application.get_env(:messaging_status_service, :calls)[:sms_response_redirect]

  def create(conn, params) do
    Logger.info("#{__MODULE__} create #{inspect(params)}")
    @sms_completed_handler.handle_sms_completed(params)
    conn
    |> put_status(:created)
    |> put_resp_content_type("text/xml")
    |> render("done.xml", response_redirect: @sms_response_redirect)
  end
end
