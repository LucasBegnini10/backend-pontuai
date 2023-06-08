defmodule PhxWeb.AccountController do 

  use PhxWeb, :controller

  alias Phx.Service.AccountService

  def create(conn, params) do 
    {status, content} = AccountService.create(params)
    
    case status do 
      :created -> conn |> put_status(:created) |> render("account.json", content: content)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :error -> conn |> put_status(:internal_server_error) |> render("500.json", content: content)
    end
  end 
end