defmodule Tasks2.UserTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.UserTasks.Task


  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :title, :string
    belongs_to :user, Tasks2.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :is_completed, :user_id])
    |> validate_required([:title, :description, :is_completed, :user_id])
  end
end
