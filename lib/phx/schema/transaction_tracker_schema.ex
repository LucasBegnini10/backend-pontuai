defmodule Phx.Schema.TransactionTrackerSchema do 
  use Ecto.Schema
  import Ecto.Changeset
  alias Phx.Schema.{TransactionTrackerSchema, UserSchema}

  @fields [:transaction_tracker_id, :points, :type, :user_id]
  @fields_required [:transaction_tracker_id, :points, :type, :user_id]

  @primary_key {:transaction_tracker_id, :string, autogenerate: false}
  
  schema "transaction_tracker" do
    field :points,           :integer
    field :type,             :boolean
    belongs_to :users, UserSchema, foreign_key: :user_id, references: :user_id 

    timestamps()
  end

  def changeset(%TransactionTrackerSchema{} = transaction_tracker, attrs \\ %{}) do
    transaction_tracker
    |> cast(params, @fields)
    |> validate_required(@fields_required)
  end

end