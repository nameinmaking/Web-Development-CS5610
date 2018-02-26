defmodule Tasktracker.UserTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.UserTasks.Task


  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :title, :string
    field :manager_id, :id
    belongs_to :user, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :is_completed])
    |> validate_required([:title, :description, :is_completed])
  end
end
