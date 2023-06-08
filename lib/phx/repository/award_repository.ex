defmodule Phx.Repository.AwardRepository do 
  alias Phx.Repo
  alias Phx.Schema.AwardSchema

  def create(attrs \\ %{}) do 
    try do
      %AwardSchema{}
      |> AwardSchema.changeset(attrs)
      |> Repo.insert()
    rescue e ->
      IO.inspect(e, label: "Create Award ===>")
      {:error, e}
    end 
  end

  def get(award_id) do 
    try do 
      Repo.get_by(AwardSchema, award_id: award_id)
    rescue e -> 
      IO.inspect(e, label: "Get Award ===>")
      {:error, e}
    end
  end

  def update(award_id, attrs \\ %{}) do 
    try do 
      Repo.get_by!(AwardSchema, award_id: award_id)
      |> AwardSchema.changeset(attrs)
      |> Repo.update()
    rescue e -> 
      IO.inspect(e, label: "Update Award ===>")
      {:error, e}
    end
  end

  def delete(award_id) do 
    try do 
      Repo.get_by!(AwardSchema, award_id: award_id)
      |> Repo.delete()
    rescue e ->
      IO.inspect(e, label: "Delete Award ==>")
      {:error, e}
    end
  end


end