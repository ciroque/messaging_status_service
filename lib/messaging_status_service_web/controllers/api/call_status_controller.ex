defmodule MessagingStatusServiceWeb.Api.CallStatusController do
  use MessagingStatusServiceWeb, :controller

  require Logger

  @call_status_handler MessagingStatusService.CallStatusHandling.HoneydewCallStatusHandler

  def create(conn, params) do
    Logger.debug("#{__MODULE__} create #{inspect(params)}")
    @call_status_handler.handle_call_status(params)
    conn |> render("create.json", %{})
  end

  def index(conn, _params) do
    conn |> render("index.json", %{})
  end
end
