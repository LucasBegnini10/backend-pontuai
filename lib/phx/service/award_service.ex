defmodule Phx.Service.AwardService do
  alias Phx.Utils.{UUID}
  alias Phx.Repository.AwardRepository

  def create(award \\ %{}) do
    award_id = UUID.generate()

    award =
      Phx.Utils.Map.key_to_atom(award)
      |> Map.merge(%{award_id: award_id})

    res = AwardRepository.create(award)

    case res do
      {:ok, schema} ->
        {:created, schema}

      {:error, error} ->
        case error do
          %Ecto.Changeset{} = _changeset ->
            {:error_changeset, error.errors}

          _ ->
            {:error, error}
        end

      _ ->
        {:error, res}
    end
  end
end
