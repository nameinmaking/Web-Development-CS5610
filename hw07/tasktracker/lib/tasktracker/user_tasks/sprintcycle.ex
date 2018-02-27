defmodule Tasktracker.UserTasks.Sprintcycle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.UserTasks.Sprintcycle


  schema "sprintcycle" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    field :start, :boolean, default: false
    belongs_to :task, Tasktracker.UserTasks.Task

    timestamps()
  end

  @doc false
  def changeset(%Sprintcycle{} = sprintcycle, attrs) do
    sprintcycle
    |> cast(attrs, [:start_time, :end_time, :task_id, :start])
    |> validate_required([:start_time, :task_id, :end_time, :start])
    |> check_constraint(:end_time, [message: "should be greater than start time", name: "end_time_must_be_greater" ])

  end
end
