defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tasktracker.UserTasks.list_tasks()
    changeset = Tasktracker.UserTasks.change_task(%Tasktracker.UserTasks.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
