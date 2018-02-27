defmodule Tasktracker2Web.PageController do
  use Tasktracker2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tasktracker2.UserTasks.list_tasks()
    changeset = Tasktracker2.UserTasks.change_task(%Tasktracker2.UserTasks.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end

end
