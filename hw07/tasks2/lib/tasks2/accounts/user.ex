defmodule Tasks2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.Accounts.User


  schema "users" do
    field :email, :string
    field :is_manager, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :is_manager])
    |> validate_required([:email, :name, :is_manager])
    |> unique_constraint(:email, name: :email_index)    # to check if email is unique
    |> validate_format(:email, ~r/@./)
  end
end
