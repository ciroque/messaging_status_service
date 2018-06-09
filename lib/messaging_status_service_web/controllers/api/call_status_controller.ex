defmodule MessagingStatusServiceWeb.Api.CallStatusController do
  use MessagingStatusServiceWeb, :controller

  require Logger

  def create(conn, params) do
    Logger.debug("#{__MODULE__} create #{inspect(params)}")
    conn |> render("create.json", %{})
  end

  def index(conn, _params) do
    conn |> render("index.json", %{})
  end
end
