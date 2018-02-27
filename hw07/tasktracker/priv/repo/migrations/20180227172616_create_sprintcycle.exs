defmodule Tasktracker.Repo.Migrations.CreateSprintcycle do
  use Ecto.Migration

  def change do
    create table(:sprintcycle) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :start, :boolean, default: false
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:sprintcycle, [:task_id])
  end
end
