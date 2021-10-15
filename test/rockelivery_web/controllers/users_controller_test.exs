defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 27,
        "address" => "Rua das bananeiras, 15",
        "cep" => "24420580",
        "cpf" => "12345678901",
        "email" => "rafael@banana.com",
        "password" => "123456",
        "name" => "Rafael"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua das bananeiras, 15",
                 "age" => 27,
                 "cpf" => "12345678901",
                 "email" => "rafael@banana.com",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Rafael"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
#      params = build(:user_params)
#      {_ok, user } = Create.call(params)

      #Factory creating on database
      user = insert(:user)
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user.id))
        |> response(:no_content)

      assert response == ""
    end
  end
end