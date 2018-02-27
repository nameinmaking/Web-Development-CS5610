defmodule Tasktracker2.UserTasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.UserTasks.Task


  schema "tasks" do
    field :complete, :boolean, default: false
    field :description, :string
    field :title, :string
    belongs_to :user, Tasktracker2.Accounts.User, foreign_key: :user_id
    belongs_to :assigned_user, Tasktracker2.Accounts.User, foreign_key: :assigned_to
    #has_many :timeblocks, Tasktracker2.UserTasks.Timeblocks, foreign_key: :task_id
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:user_id, :title, :description, :assigned_to, :complete])
    |> validate_required([:user_id,:title, :description, :complete])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:assigned_to)

  end
end
