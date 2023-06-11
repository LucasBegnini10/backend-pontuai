defmodule Phx.Utils.Encrypt do 
  import Argon2
  
  def add_hash(password) do
    %{password_hash: password_hash} = Argon2.add_hash(password)
    password_hash
  end

  def verify_password(password, hash) do 
    Argon2.verify_pass(password, hash)
  end
end