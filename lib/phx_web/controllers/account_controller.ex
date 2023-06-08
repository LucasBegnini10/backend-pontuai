defmodule PhxWeb.AccountController do 

  use PhxWeb, :controller

  alias Phx.Service.AccountService

  def create(conn, params) do 
    {status, content} = AccountService.create(params)
    
    case status do 
      201 -> conn |> put_status(status) |> render("account.json", content: content)
      400 -> conn |> put_status(status) |> render("error-changeset.json", content: content)
      500 -> conn |> put_status(status) |> render("500.json", content: content)
    end
  end 
end