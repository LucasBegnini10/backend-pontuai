defmodule PhxWeb.UserController do 

  use PhxWeb, :controller
  alias Phx.Service.SessionService
  alias Phx.Service.UserService

  def create(conn, params) do 
    {status, content} = UserService.create(params)
    
    case status do 
      :created -> conn |> put_status(:created) |> render("user-created.json", user: content)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :error -> conn |> put_status(:internal_server_error) |> render("500.json", content: content)
    end
  end 

  def auth(conn, %{"identifier" => identifier, "password" => password}) do
    case SessionService.new(%{"identifier" => identifier, "password" => password}) do 
      {:ok, token} -> conn |> put_status(:ok) |> render("authenticated.json", token: token)
      {:error, _message} ->  
        conn
          |> put_status(:unauthorized)
          |> put_view(PhxWeb.ErrorJSON)
          |> render("401.json")
          |> halt()
    end
  end

  def update(conn, params) do 
    user_id = params["user_id"]

    {status, content} = UserService.update(user_id, params)

    case status do 
      :updated -> conn |> put_status(:ok) |> render("user-updated.json", user: content)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :no_result -> conn |> put_status(:not_found) |> render("user-not-found.json", user_id: user_id)
      :error -> conn |> put_status(:internal_server_error) |> render("500.json", content: content)
    end
  end
  
end