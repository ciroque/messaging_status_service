defmodule MessagingStatusServiceWeb.Router do
  use MessagingStatusServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MessagingStatusServiceWeb.Api do
    pipe_through :api

    resources "/sms", SmsStatusController, only: [:index, :create]
    resources "/call", CallStatusController, only: [:index, :create]
  end
end
