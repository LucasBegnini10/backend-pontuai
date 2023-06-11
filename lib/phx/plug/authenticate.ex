defmodule Phx.Plug.Authenticate do
  import Plug.Conn
  require Logger

  alias Phx.Utils.Token
  alias Phx.Service.UserService

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      conn
      |> assign(:current_user, UserService.get(data.user_id))
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(PhxWeb.ErrorJSON)
        |> Phoenix.Controller.render("401.json")
        |> halt()
    end
  end
end