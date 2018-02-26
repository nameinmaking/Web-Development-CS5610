defmodule TasktrackerWeb.TaskView do
  use TasktrackerWeb, :view

  # A [key, values] pair of [usernames, id]
  def get_names do
    Enum.map(Tasktracker.Accounts.list_users(), &{&1.name, &1.id})
  end
end
