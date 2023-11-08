defmodule RatingWeb.Router do
  use RatingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RatingWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RatingWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", RatingLive
    live "/rating", RatingLive
    live "/rating-list", RatingListLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", RatingWeb do
  #   pipe_through :api
  # end
end
