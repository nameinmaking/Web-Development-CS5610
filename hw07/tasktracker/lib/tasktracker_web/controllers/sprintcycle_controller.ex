defmodule TasktrackerWeb.SprintcycleController do
  use TasktrackerWeb, :controller

  alias Tasktracker.UserTasks
  alias Tasktracker.UserTasks.Sprintcycle

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    sprintcycle = UserTasks.list_sprintcycle()
    render(conn, "index.json", sprintcycle: sprintcycle)
  end

  def create(conn, %{"sprintcycle" => sprintcycle_params}) do
    sprintcycle_param = Enum.drop(sprintcycle_params,-2)
    with {:ok, %Sprintcycle{} = sprintcycle} <- UserTasks.create_sprintcycle(sprintcycle_params) do
      render(conn, "show.json", sprintcycle: sprintcycle)
    end
  end

  def show(conn, %{"id" => id}) do
    sprintcycle = UserTasks.get_sprintcycle!(id)
    render(conn, "show.json", sprintcycle: sprintcycle)
  end

  def update(conn, %{"id" => id, "sprintcycle" => sprintcycle_params}) do
    sprintcycle = UserTasks.get_sprintcycle!(id)

    with {:ok, %Sprintcycle{} = sprintcycle} <- UserTasks.update_sprintcycle(sprintcycle, sprintcycle_params) do
      render(conn, "show.json", sprintcycle: sprintcycle)
    end
  end

  def delete(conn, %{"id" => id}) do
    sprintcycle = UserTasks.get_sprintcycle!(id)
    # with {:ok, %Sprintcycle{}} <- UserTasks.delete_sprintcycle(sprintcycle) do
    #   send_resp(conn, :no_content, "")
    # end
    {:ok, _sprintcycle} = UserTasks.delete_sprintcycle(sprintcycle)
    conn
    |> put_flash(:info, "TimeBlock deleted successfully.")
    |> redirect(to: task_path(conn, :show, sprintcycle.task_id))
  end

  def new(conn, _params) do
    conn
    |>IO.inspect
    changeset = UserTasks.change_sprintcycle(%Sprintcycle{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    sprintcycle = UserTasks.get_sprintcycle!(id)
    changeset = UserTasks.change_sprintcycle(sprintcycle)
    render(conn, "edit.html", sprintcycle: sprintcycle, changeset: changeset)
  end

  def web_create(conn, %{"sprintcycle" => sprintcycle_params}) do
    case UserTasks.create_sprintcycle(sprintcycle_params) do
      {:ok, sprintcycle} ->
        conn
        |> put_flash(:info, "Timeblock created successfully.")
        |> redirect(to: task_path(conn, :show, Tasktracker.UserTasks.get_task(sprintcycle_params["task_id"])))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def web_update(conn, %{"id" => id, "sprintcycle" => sprintcycle_params}) do
    sprintcycle = UserTasks.get_sprintcycle!(id)
    case UserTasks.update_sprintcycle(sprintcycle, sprintcycle_params) do
      {:ok, sprintcycle} ->
        conn
        |> put_flash(:info, "TimeBlock updated successfully.")
        |> redirect(to: task_path(conn, :show, Tasktracker.UserTasks.get_task(sprintcycle.task_id)))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sprintcycle: sprintcycle, changeset: changeset)
    end
  end

end
