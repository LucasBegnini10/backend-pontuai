defmodule Phx.Schema.AwardSchema do 
  use Ecto.Schema
  import Ecto.Changeset
  alias Phx.Schema.AwardSchema

  @fields [:award_id, :name, :points, :description, :status]
  @fields_required [:award_id, :name, :points, :description, :status]

  @primary_key {:award_id, :string, autogenerate: false}
  
  schema "awards" do
    field :name,             :string
    field :points,           :integer
    field :description,      :string
    field :status,           :boolean,         default: true

    timestamps()
  end

  def changeset(%AwardSchema{} = award, params \\ %{}) do
    award
    |> cast(params, @fields)
    |> validate_required(@fields_required)
  end

end