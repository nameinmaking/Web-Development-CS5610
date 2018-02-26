defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User


  schema "users" do
    field :email, :string
    field :is_manager, :boolean, default: false
    field :manager_id, :integer, default: 0
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id, :is_manager])
    |> validate_required([:email, :name, :manager_id, :is_manager])
  end
end
