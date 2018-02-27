defmodule Tasktracker2Web.Router do
  use Tasktracker2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :get_current_user
    plug :get_current_task
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :get_current_user
    plug :get_current_task
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Tasktracker2Web do
    pipe_through :api
    resources "/sprintcycle", SprintcycleController
  end

  # Getting user and the Task(s)
  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    task_id = get_session(conn, :task_id)
    user = Tasktracker2.Accounts.get_user(user_id || -1)
    conn
    |> assign(:current_user, user)
    |> assign(:current_task, task_id)
  end


  # The current Task
  def get_current_task(conn, _params) do
    task_id = get_session(conn, :task_id)
    conn
    |> assign(:current_task, task_id)
  end


  scope "/", Tasktracker2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController    # Controller for users table
    resources "/tasks", TaskController    # Controller for tasks table
    post "/session", SessionController, :create     # creation
    delete "/session", SessionController, :delete   # deletion
    get "/feed", PageController, :feed  # feed route

    post "/session_task", SessionController, :task_create #task creation

    # Sprintcycle routes
    get "/sprintcycle/new", SprintcycleController, :new
    post "/sprintcycle/create", SprintcycleController, :web_create
    get "/sprintcycle/:id/edit", SprintcycleController, :edit
    put "/sprintcycle/:id", SprintcycleController, :web_update
  end


end
