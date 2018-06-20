defmodule MessagingStatusServiceWeb.Router do
  use MessagingStatusServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MessagingStatusServiceWeb.Api do
    pipe_through :api

    resources "/sms", SmsController, only: [:create]
    resources "/call", CallController, only: [:index, :create]
  end
end
