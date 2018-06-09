defmodule MessagingStatusServiceWeb.Router do
  use MessagingStatusServiceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MessagingStatusServiceWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", MessagingStatusServiceWeb.Api do
    pipe_through :api

    resources "/sms", SmsStatusController, only: [:index, :create]
    resources "/call", CallStatusController, only: [:index, :create]
  end
end
