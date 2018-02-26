defmodule Tasks2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :is_manager, :boolean, default: false, null: false

      timestamps()
    end

    # To constraint email to be unique
    create unique_index(:users,[:email], name: :email_index)

  end
end
