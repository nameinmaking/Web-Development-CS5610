defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User

  schema "users" do
    field :email, :string
    field :name, :string
    belongs_to :manager1, Tasktracker.Accounts.User, foreign_key: :manager_id
    has_one :manager, Tasktracker.Accounts.User, on_delete: :nilify_all, foreign_key: :manager_id
    has_many :task, Tasktracker.UserTasks.Task, on_delete: :nilify_all, foreign_key: :user_id
    has_many :assigned_task, Tasktracker.UserTasks.Task, on_delete: :nilify_all, foreign_key: :assigned_to
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
  end
end
