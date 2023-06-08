defmodule Phx.Utils.UUID do 
  # import Ecto

  def generate do 
    Ecto.UUID.generate
  end

end