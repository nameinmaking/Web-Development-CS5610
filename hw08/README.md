# Tasktracker #2| HW07
### An Application to keep track of their tasks and assign them to others.

#### Users of this application should be able to (in addition to the v1 [as specified below]):
  * A user can select his/her Manager
  * Only a manger can assign a task to it's underling
  * User profile page shows the Manager and Underling details
  * Managers are able to see a task report, which shows a table of tasks assigned to their underlings and the status of those tasks.
  * The logged-in user can see **only** his/her profile.
  * Users can now record their work sprint, by clicking on start/stop
  * Users can also record their work as Sprint Blocks manually too


## Additional Features:
  * A better feed
  * A navigation bar will be available to the user after they login.
  * Only the **Mangers** will be given access to see Task Dashboard (from the navgation bar)

Tracking time only in 15-minute increments is removed now.
___
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