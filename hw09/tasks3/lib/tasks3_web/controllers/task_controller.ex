defmodule Tasks3Web.TaskController do
  use Tasks3Web, :controller

  alias Tasks3.UserTasks
  alias Tasks3.UserTasks.Task

  action_fallback Tasks3Web.FallbackController

  def index(conn, _params) do
    tasks = UserTasks.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- UserTasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = UserTasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = UserTasks.get_task!(id)

    with {:ok, %Task{} = task} <- UserTasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = UserTasks.get_task!(id)
    with {:ok, %Task{}} <- UserTasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
