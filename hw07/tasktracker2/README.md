# Tasktracker #1| HW06
### An Application to keep track of their tasks and assign them to others.

#### Users of this application should be able to:
  * Register an account
  * Log in/Log put
  * Create Tasks, entering a title and description
  * Assign Tasks to themselves or other users
  * Track how ling they've worked on a task they're assigned to, in 15-minute increments.
  * Mark a task as completed.

_To log in, it's sufficient for a user to enter their name (or email address)._

___

# Design choices for the Assignment
  * A drop-down menu is provided to select to whom the task should be assigned, as giving in user ID instead is tedious and not user friendly.
  * The time tracking is manual right now, with an increment of 15 minutes at any instant.
  * The task can marked, completed and incomplete as many times as required. It is assumed that the task can be required in future to be re-done due to any mistakes or issues in production system.

###### Known Errors:
> The application will fail if we create a task without logging in first. Am working on restricting access to Task page, when the user is not logged in.
___

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
