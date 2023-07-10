defmodule Phx.Utils.Map do
  def key_to_atom(map) do
    Enum.map(map, fn {k, v} ->
      k =
        if is_bitstring(k) do
          String.to_atom(k)
        else
          k
        end

      {k, v}
    end)
    |> Map.new()
  end
end
