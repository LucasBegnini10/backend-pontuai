defmodule Phx.Service.SessionService do
  
  alias Phx.Service.UserService
  alias Phx.Utils.Token

  alias Phx.Schema.UserSchema

  def new(%{"identifier" => identifier, "password" => password}) do
     case UserService.authenticate_user(identifier, password) do 
      {:ok, %UserSchema{} = user} ->
        {:ok, Token.sign(content_token(user))}
      _ ->
        {:error, "identifier or password is in correct"}
     end
  end

  defp content_token(user) do 
    %{
      user_id: user.user_id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      document: user.document,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

end