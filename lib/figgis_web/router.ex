defmodule FiggisWeb.Router do
  use FiggisWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery

    plug :put_secure_browser_headers, %{
      "content-security-policy" =>
        "default-src 'self'; script-src 'self' 'unsafe-eval'; style-src 'self' 'unsafe-inline'"
    }
  end

  pipeline :api do
    plug JSONAPI.EnsureSpec
    plug JSONAPI.UnderscoreParameters
  end

  scope "/", FiggisWeb do
    pipe_through :browser

    resources "/", ProjectController, as: :project do
      resources "/metrics", MetricController, except: [:index]
    end
  end

  scope "/api", FiggisWeb, as: :api do
    pipe_through :api

    post "/metrics/:metric_id/data", Api.DataController, :create
  end
end
