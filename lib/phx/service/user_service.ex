defmodule Phx.Service.UserService do 

  alias Phx.Repository.UserRepository

  def get(user_id) do 
    case UserRepository.get(user_id) do 
      {:ok, user} -> user
      _ -> nil
    end
  end

end