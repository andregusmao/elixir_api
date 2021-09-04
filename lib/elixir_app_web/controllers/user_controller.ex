defmodule ElixirAppWeb.UserController do
  use ElixirAppWeb, :controller

  alias ElixirApp.Accounts
  alias ElixirApp.Accounts.User

  action_fallback ElixirAppWeb.FallbackController

  def index(conn, _params) do
    try do
      user = Accounts.list_user()
      render(conn, "index.json", user: user)
    rescue
      ArgumentError -> generic_error(conn)
    end
  end

  def create(conn, %{"user" => user_params}) do
    try do
      with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    rescue
      ArgumentError -> generic_error(conn)
    end
  end

  def show(conn,%{"id" => id}) do
    try do
      user = Accounts.get_user!(id)
      render(conn, "show.json", user: user)
    rescue
      Ecto.NoResultsError -> notfound(conn)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    try do
      user = Accounts.get_user!(id)
      with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
        render(conn, "show.json", user: user)
      end
    rescue
      Ecto.NoResultsError -> notfound(conn)
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      user = Accounts.get_user!(id)
      with {:ok, %User{}} <- Accounts.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> notfound(conn)
    end
  end

  defp notfound(conn) do
    conn
    |> put_status(404)
    |> render("notfound.json")
  end

  defp generic_error(conn) do
    conn
    |> put_status(500)
    |> render("generic_error.json")
  end
end
