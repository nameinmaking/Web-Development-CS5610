defmodule Tasks2Web.SessionController do
  use Tasks2Web, :controller

  alias Tasks2.Accounts
  alias Tasks2.Accounts.User

  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)

    if conn do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.name}")
      |> redirect(to: task_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Cannot create session")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged Out")
    |> redirect(to: page_path(conn, :index))
  end
end
