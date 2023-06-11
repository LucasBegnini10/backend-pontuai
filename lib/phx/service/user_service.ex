defmodule Phx.Service.UserService do 

  alias Phx.Utils.Encrypt
  alias Phx.Repository.UserRepository
  alias Phx.Utils.UUID
  alias Phx.Schema.UserSchema
  alias Phx.Service.SessionService

  def get(user_id) do 
    case UserRepository.get(user_id) do 
      %UserSchema{} = user -> user
      _ -> nil
    end
  end

  def create(user  \\ %{}) do 
    user_id = UUID.generate()
    password_hashed = Encrypt.add_hash(user["password"])
    
    user = user |> Map.merge(%{"user_id" => user_id, "password" => password_hashed})

    res = UserRepository.create(user)

    case res do
      {:ok, schema} -> {:created, schema}
      {:error, error} ->
        case error do 
          %Ecto.Changeset{} = _changeset ->
            {:error_changeset, error.errors}
          _ -> {:error, error}
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

  def update(user_id, attrs \\ %{}) do 
    user = %{
      email: attrs["email"],
      first_name: attrs["first_name"],
      last_name: attrs["last_name"],
      password: attrs["password"] != nil && Encrypt.add_hash(attrs["password"]) || nil
    } |> Map.to_list() |> Enum.reject(fn {_, v} -> is_nil(v) end) |> Map.new

    res = UserRepository.update(user_id, user)
    
    case res do 
      {:ok, schema} -> 
        token = SessionService.sign(schema)
        {:updated, {schema, token}}
      {:error, error} ->
        case error do 
          %Ecto.Changeset{} = _changeset ->
            {:error_changeset, error.errors}
          %Ecto.NoResultsError{} = no_result ->
            {:no_result, no_result.message}
          _ -> {:error, error}
        end
      _ -> {:error, res}
    end
  end

  def delete(user_id) do 
    res = UserRepository.delete(user_id)
    case res do
      {:ok, schema} -> {:deleted, schema}
      {:error, error} ->
        case error do 
          %Ecto.NoResultsError{} = _changeset ->
            {:not_found, error}
          _ -> {:error, error}
        end
        _ -> {:error, res}
    end

  end

  def get_points(user_id) do 
    UserRepository.get_points(user_id) 
  end
  

end