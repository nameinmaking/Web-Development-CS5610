defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :is_completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :manager_id, references(:users, on_delete: :nilify_all), null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
    create index(:tasks, [:manager_id])
  end
end
