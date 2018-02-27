defmodule Tasktracker2.UserTasks do
  @moduledoc """
  The UserTasks context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker2.Repo

  alias Tasktracker2.UserTasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
     |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
     |> Repo.preload(:user)
  end

  def get_task(id) do
    Repo.get(Task, id)
     |> Repo.preload(:user)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end


  # get task assigned to people under a manager
  def get_task_by_manager_id(id) do
    id_set = Tasktracker2.Accounts.get_id_by_manager_id(id);
    Repo.all(
      from p in Task,
      where: p.assigned_to in ^id_set
    )
  end

  alias Tasktracker2.UserTasks.Sprintcycle

  @doc """
  Returns the list of sprintcycle.

  ## Examples

      iex> list_sprintcycle()
      [%Sprintcycle{}, ...]

  """
  def list_sprintcycle do
    Repo.all(Sprintcycle)
    |> Repo.preload(:task)
  end

  @doc """
  Gets a single sprintcycle.

  Raises `Ecto.NoResultsError` if the Sprintcycle does not exist.

  ## Examples

      iex> get_sprintcycle!(123)
      %Sprintcycle{}

      iex> get_sprintcycle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sprintcycle!(id), do: Repo.get!(Sprintcycle, id)

  @doc """
  Creates a sprintcycle.

  ## Examples

      iex> create_sprintcycle(%{field: value})
      {:ok, %Sprintcycle{}}

      iex> create_sprintcycle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sprintcycle(attrs \\ %{}) do
    %Sprintcycle{}
    |> Sprintcycle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sprintcycle.

  ## Examples

      iex> update_sprintcycle(sprintcycle, %{field: new_value})
      {:ok, %Sprintcycle{}}

      iex> update_sprintcycle(sprintcycle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sprintcycle(%Sprintcycle{} = sprintcycle, attrs) do
    sprintcycle
    |> Sprintcycle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sprintcycle.

  ## Examples

      iex> delete_sprintcycle(sprintcycle)
      {:ok, %Sprintcycle{}}

      iex> delete_sprintcycle(sprintcycle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sprintcycle(%Sprintcycle{} = sprintcycle) do
    Repo.delete(sprintcycle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sprintcycle changes.

  ## Examples

      iex> change_sprintcycle(sprintcycle)
      %Ecto.Changeset{source: %Sprintcycle{}}

  """
  def change_sprintcycle(%Sprintcycle{} = sprintcycle) do
    Sprintcycle.changeset(sprintcycle, %{})
  end

  def time_maps_for do
    Repo.all(
      from p in Sprintcycle,
      where: p.start==^true
    )
    |> Enum.map(&({&1.task_id, &1.id}))
    |> Enum.into(%{})
  end

  def get_sprintcycle_by_task_id(id) do
    Repo.all(
      from p in Sprintcycle,
      where: p.start==^false and p.task_id==^id
    )
  end
end
