defmodule Tasks2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :is_manager, :boolean, default: false, null: false
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
