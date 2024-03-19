defmodule ContextWeb.Router do
  use ContextWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ContextWeb do
    pipe_through :api
  end
end
