defmodule MessagingStatusServiceWeb.Api.CallController do
  use MessagingStatusServiceWeb, :controller

  require Logger

  @call_completed_handler Application.get_env(:messaging_status_service, :calls)[:call_completed_handler]

  def create(conn, params) do
    Logger.debug("#{__MODULE__} create #{inspect(params)}")
    @call_completed_handler.handle_call_completed(params)
    conn
    |> put_status(:created)
    |> put_resp_content_type("text/xml")
    |> render("hang-up.xml", %{})
  end
end
