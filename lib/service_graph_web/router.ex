defmodule ServiceGraphWeb.Router do
  use ServiceGraphWeb, :router

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

  scope "/", ServiceGraphWeb do
    pipe_through :browser

    resources "/services", ServiceController
    resources "/teams", TeamController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ServiceGraphWeb do
    pipe_through :api

    post "/relations/:service_name/bulk_definition", Api.RelationController, :bulk_definition
  end
end
