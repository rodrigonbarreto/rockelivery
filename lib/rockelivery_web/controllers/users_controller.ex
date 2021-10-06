defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.Repo
  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def index(conn,_params) do
    users = Repo.all(Rockelivery.User)
    render(conn, "index.json", users: users)
    #or use ==> json conn, users
    #or with name(data) ==> json conn, %{data: users}
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def delete(conn, %{"id" => id }) do
    with {:ok, %User{}} <- Rockelivery.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id }) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end

#    case Rockelivery.update_user(params) do
#      {:ok, user} -> conn
#        |> put_status(:ok)
#        |> render("user.json", user: user)
#
#      {:error, %Ecto.Changeset{} = user} ->
#        render(conn, "error.json", message: user)
#        json conn, "error"
#    end
  end
end