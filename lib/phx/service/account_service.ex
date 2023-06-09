defmodule Phx.Service.AccountService do 

  alias Phx.Utils.Encrypt

  alias Phx.Repository.UserRepository
  alias Phx.Utils.UUID
  alias Phx.Schema.UserSchema

  def create(user  \\ %{}) do 
    user_id = UUID.generate()
    password_hashed = Encrypt.add_hash(user["password"])
    
    user = user |> Map.merge(%{"user_id" => user_id, "password" => password_hashed})

    res = UserRepository.create(user)

    case res do
      {:ok, schema} -> {:created, schema}
      {:error, error} ->
        if error.__struct__ == Ecto.Changeset do 
          {:error_changeset, error.errors}
        else
          {:error, error}
        end
        _ -> {:error, res}
      end
  end

  def authenticate_user(identifier, password) do 
    case UserRepository.get_by_identifier(identifier) do 
      %UserSchema{} = user -> 
        if Encrypt.verify_password(password, user.password) do 
          {:ok, user}
        else 
          {:error, nil}
        end
      _ -> {:error, nil}
    end
  end 

end