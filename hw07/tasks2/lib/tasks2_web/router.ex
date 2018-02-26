defmodule Tasks2Web.Router do
  use Tasks2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :get_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Tasks2.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  scope "/", Tasks2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController    # Controller for users table
    resources "/tasks", TaskController    # Controller for tasks table
    post "/session", SessionController, :create     # creation
    delete "/session", SessionController, :delete   # deletion
    get "/feed", PageController, :feed  # feed route
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tasks2Web do
  #   pipe_through :api
  # end
end
