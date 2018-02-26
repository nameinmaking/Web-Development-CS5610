defmodule Tasks2Web.PageController do
  use Tasks2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
  tasks = Tasks2.UserTasks.list_tasks()
  changeset = Tasks2.UserTasks.change_task(%Tasks2.UserTasks.Task{})
  render conn, "feed.html", tasks: tasks, changeset: changeset
end
end
