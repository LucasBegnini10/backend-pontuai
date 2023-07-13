defmodule Phx.Repository.AwardRepository do
  alias Phx.Repo
  alias Phx.Schema.AwardSchema

  def create(attrs \\ %{}) do
    try do
      %AwardSchema{}
      |> AwardSchema.changeset(attrs)
      |> Repo.insert()
      |> handle_result()
    rescue
      e ->
        handle_error("Create Award", e)
    end
  end

  def get(award_id) do
    try do
      Repo.get_by(AwardSchema, award_id: award_id)
    rescue
      e ->
        handle_error("Get Award", e)
    end
  end

  def update(award_id, attrs \\ %{}) do
    try do
      Repo.get_by!(AwardSchema, award_id: award_id)
      |> AwardSchema.changeset(attrs)
      |> Repo.update()
      |> handle_result()
    rescue
      e ->
        case e do
          %Ecto.NoResultsError{} = error -> :error_not_found
          _ -> :error
        end
    end
  end

  def delete(award_id) do
    try do
      Repo.get_by!(AwardSchema, award_id: award_id)
      |> Repo.delete()
      |> handle_result()
    rescue
      e ->
        case e do
          %Ecto.NoResultsError{} = error -> :error_not_found
          _ -> :error
        end
    end
  end

  defp handle_result({:ok, result}), do: {:ok, result}
  defp handle_result({:error, error}), do: {:error, error}
  defp handle_result(result), do: result

  defp handle_error(label, e) do
    IO.inspect(e, label: "#{label} ===>")
    {:error, e}
  end
end
