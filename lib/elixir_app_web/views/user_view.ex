defmodule ElixirAppWeb.UserView do
  use ElixirAppWeb, :view
  alias ElixirAppWeb.UserView

  def render("index.json", %{user: user}) do
    %{data: render_many(user, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      password: user.password}
  end

  def render("notfound.json", _params) do
    %{message: "user not found"}
  end
end
