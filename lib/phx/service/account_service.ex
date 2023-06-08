defmodule Phx.Service.AccountService do 

  alias Phx.Utils.Encrypt

  alias Phx.Repository.UserRepository
  alias Phx.Utils.UUID

  def create(user  \\ %{}) do 
    user_id = UUID.generate()
    password_hashed = Encrypt.add_hash(user["password"])
    
    user = user |> Map.merge(%{"user_id" => user_id, "password" => password_hashed})

    res = UserRepository.create(user)

    case res do
      {:ok, schema} -> {201, schema}
      {:error, error} ->
        if error.__struct__ == Ecto.Changeset do 
          {400, error.errors}
        else
          {500, error}
        end
        _ -> {500, res}
      end
  end

end