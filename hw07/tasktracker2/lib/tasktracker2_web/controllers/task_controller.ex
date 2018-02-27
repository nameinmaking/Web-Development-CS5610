defmodule Tasktracker2Web.TaskController do
  use Tasktracker2Web, :controller

  alias Tasktracker2.UserTasks
  alias Tasktracker2.UserTasks.Task
  alias Tasktracker2.UserTasks.Sprintcycle

  def index(conn, _params) do
    tasks = UserTasks.list_tasks()
    sprintcycle = UserTasks.time_maps_for()
    render(conn, "index.html", tasks: tasks, sprintcycle: sprintcycle)
  end

  def new(conn, _params) do
    changeset = UserTasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case UserTasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = UserTasks.get_task!(id)
    sprintcycle = UserTasks.get_sprintcycle_by_task_id(id)
    conn=assign(conn, :task_id, id)
    changeset = UserTasks.change_sprintcycle(%Sprintcycle{})
    render(conn, "show.html", task: task, sprintcycle: sprintcycle)
  end

  def edit(conn, %{"id" => id}) do
    task = UserTasks.get_task!(id)
    changeset = UserTasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = UserTasks.get_task!(id)

    case UserTasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = UserTasks.get_task!(id)
    {:ok, _task} = UserTasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
