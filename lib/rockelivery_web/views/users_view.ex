defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end

  def render("show.json", %{user: %User{} = user}), do: %{user: user}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "listuser.json", as: :user)}
  end

  def render("listuser.json", %{user: user}) do
      user
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}

end
