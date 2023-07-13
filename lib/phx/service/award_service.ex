defmodule Phx.Service.AwardService do
  alias Phx.Utils.UUID
  alias Phx.Repository.AwardRepository
  alias Phx.Schema.AwardSchema

  def create(award \\ %{}) do
    award_id = UUID.generate()

    award =
      award
      |> Map.put_new(:award_id, award_id)
      |> Phx.Utils.Map.key_to_atom()

    case AwardRepository.create(award) do
      {:ok, schema} ->
        {:created, schema}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error_changeset, changeset.errors}

      {:error, error} ->
        {:error, error}
    end
  end

  def get(award_id) do
    AwardRepository.get(award_id)
  end

  def update(award_id, params) do
    case AwardRepository.update(award_id, params) do
      {:ok, updated_award} ->
        {:updated, updated_award}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error_changeset, changeset.errors}

      :error_not_found ->
        :error_not_found

      {:error, error} ->
        {:error, error}
    end
  end

  def delete(award_id) do
    case AwardRepository.delete(award_id) do
      {:ok, _} -> :ok
      :error_not_found -> :error_not_found
      _ -> :error
    end
  end
end
