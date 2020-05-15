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
    plug CORSPlug, origin: ["*"], headers: ["*"]
    plug :accepts, ["json"]
  end

  scope "/", ServiceGraphWeb do
    pipe_through :browser

    get "/services", ServiceController, :index
    get "/services/new", ServiceController, :new
    get "/services/:service_name", ServiceController, :show
    post "/services", ServiceController, :create
    delete "/services/:service_name", ServiceController, :delete

    resources "/teams", TeamController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ServiceGraphWeb do
    pipe_through :api
    post "/relations/:service_name/bulk_definition", Api.RelationController, :bulk_definition
    get "/services", Api.ServicesController, :list
    get "/services/:title", Api.ServicesController, :show
    delete "/services/:title", Api.ServicesController, :delete
    options "/services/:title", Api.ServicesController, :options

    get "/teams", Api.TeamsController, :list
    get "/teams/:id", Api.TeamsController, :show
    post "/teams/create", Api.TeamsController, :create
    options "/teams/create", Api.TeamsController, :options
    post "/teams/:id", Api.TeamsController, :update
    options "/teams/:id", Api.TeamsController, :options
    get "/graph", Api.RelationController, :graph
  end
end
