defmodule MessagingStatusServiceWeb.Router do
  use MessagingStatusServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MessagingStatusServiceWeb.Api do
    pipe_through :api

    resources "/sms", SmsCompletedController, only: [:index, :create]
    resources "/call", CallCompletedController, only: [:index, :create]
  end
end
