defmodule TasktrackerWeb.SprintcycleView do
  use TasktrackerWeb, :view
  alias TasktrackerWeb.SprintcycleView

  def render("index.json", %{sprintcycle: sprintcycle}) do
    %{data: render_many(sprintcycle, SprintcycleView, "sprintcycle.json")}
  end

  def render("show.json", %{sprintcycle: sprintcycle}) do
    %{data: render_one(sprintcycle, SprintcycleView, "sprintcycle.json")}
  end

  def render("sprintcycle.json", %{sprintcycle: sprintcycle}) do
    %{id: sprintcycle.id,
      task_id: sprintcycle.task_id,
      start_time: sprintcycle.start_time,
      end_time: sprintcycle.end_time,
      start: sprintcycle.start}
  end
end
