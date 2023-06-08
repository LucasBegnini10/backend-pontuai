defmodule Phx.Service.AccountService do 

  alias Phx.Repository.UserRepository
  alias Phx.Utils.UUID

  def create(user  \\ %{}) do 
    user_id = UUID.generate()
    user = user |> Map.put("user_id", user_id)

    case UserRepository.create(user) do
      {:ok, schema} -> {201, schema}
      {:error, error} ->
        if error.__struct__ == Ecto.Changeset do 
          {400, error.errors}
        else
          {500, error}
        end
    end

  end

end