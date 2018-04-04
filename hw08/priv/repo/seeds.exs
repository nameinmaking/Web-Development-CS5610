# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks3.Repo.insert!(%Tasks3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  alias Tasks3.Repo
  alias Tasks3.Users.User
  alias Tasks3.Tasks.Task

  def run do
    p = Comeonin.Argon2.hashpwsalt("Password1")

    Repo.delete_all(User)

    a = Repo.insert!(%User{email: "alice@example.com",name: "Alice",password_hash: p})
    b = Repo.insert!(%User{email: "bob@example.com",name: "Bob",password_hash: p})
    c = Repo.insert!(%User{email: "carol@example.com",name: "Carol",password_hash: p})
    d = Repo.insert!(%User{email: "dave@example.com",name: "Dave",password_hash: p})

    Repo.delete_all(Task)

    Repo.insert!(%Task{title: "Alice's Task #1",description: "What is this life if, full of care?",
                  completed: true, time_spent: 0,user_id: a.id,creator_id: a.id})
    Repo.insert!(%Task{title: "Bob's Task #1",description: "We have no time to stand and stare.",
                  completed: true,time_spent: 15,user_id: b.id,creator_id: b.id})
    Repo.insert!(%Task{title: "Bob's Task #2",description: "No time to stand beneath the boughs",
                  completed: false,time_spent: 15,user_id: b.id,creator_id: a.id})
    Repo.insert!(%Task{title: "Carol's task #1",description: "And stare as long as sheep and cows",
                  completed: false,time_spent: 45,user_id: c.id,creator_id: c.id})
    Repo.insert!(%Task{title: "Dave's Task #1",description: "No time to see, in borad daylight,",
                  completed: true,time_spent: 0,user_id: d.id,creator_id: d.id})
    Repo.insert!(%Task{title: "Dave's Task #2",description: "Streams full of stars, like skies at night. ",
                  completed: true,time_spent: 30,user_id: d.id,creator_id: d.id})
  end
end

Seeds.run
