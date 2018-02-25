defmodule Tasks2.UserTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.UserTasks.Task


  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :title, :string
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
