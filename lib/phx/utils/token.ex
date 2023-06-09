defmodule Phx.Utils.Token do
  @signing_salt "key-token"
  # token for 2 week
  @token_age_secs 14 * 86_400

  @doc """
  Create token for given data
  """
  @spec sign(map()) :: binary()
  def sign(data) do
    Phoenix.Token.sign(PhxWeb.Endpoint, @signing_salt, data)
  end


  @doc """
  Verify given token by:
  - Verify token signature
  - Verify expiration time
  """
  @spec verify(String.t()) :: {:ok, any()} | {:error, :unauthorized}
  def verify(token) do
    case Phoenix.Token.verify(PhxWeb.Endpoint, @signing_salt, token, max_age: @token_age_secs) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthorized}
    end
  end
end