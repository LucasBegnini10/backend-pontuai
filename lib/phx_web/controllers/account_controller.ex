defmodule PhxWeb.AccountController do 

  use PhxWeb, :controller
  alias Phx.Service.SessionService
  alias Phx.Service.AccountService

  def create(conn, params) do 
    {status, content} = AccountService.create(params)
    
    case status do 
      :created -> conn |> put_status(:created) |> render("user-created.json", content: content)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :error -> conn |> put_status(:internal_server_error) |> render("500.json", content: content)
    end
  end 

  def auth(conn, %{"identifier" => identifier, "password" => password}) do
    case SessionService.new(%{"identifier" => identifier, "password" => password}) do 
      {:ok, token} -> conn |> put_status(:ok) |> render("authenticated.json", token: token)
      {:error, message} ->  
        conn
          |> put_status(:unauthorized)
          |> put_view(PhxWeb.ErrorJSON)
          |> render("401.json")
          |> halt()
    end
  end

  def delete(conn, _params) do 
    json(conn, %{teste: true})
  end
  
end