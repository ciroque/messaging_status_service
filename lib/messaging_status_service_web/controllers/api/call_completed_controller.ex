defmodule MessagingStatusServiceWeb.Api.CallCompletedController do
  use MessagingStatusServiceWeb, :controller

  require Logger

  @call_completed_handler Application.get_env(:messaging_status_service, :calls)[:call_completed_handler]

  def create(conn, params) do
    Logger.debug("#{__MODULE__} create #{inspect(params)}")
    @call_completed_handler.handle_call_completed(params)
    conn |> put_status(:accepted) |> render("create.json", %{})
  end

  def index(conn, _params) do
    conn |> render("index.json", %{})
  end
end
