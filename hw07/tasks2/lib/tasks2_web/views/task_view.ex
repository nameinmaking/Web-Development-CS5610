defmodule Tasks2Web.TaskView do
  use Tasks2Web, :view

  # A [key, values] pair of [usernames, id]
  def get_names do
    Enum.map(Tasks2.Accounts.list_users(), &{&1.name, &1.id})
  end
end
