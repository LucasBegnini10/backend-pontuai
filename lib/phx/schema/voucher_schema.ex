defmodule Phx.Schema.VoucherSchema do 
  use Ecto.Schema
  import Ecto.Changeset
  alias Phx.Schema.{UserSchema, AwardSchema, VoucherSchema}

  @fields [:voucher_id, :user_id, :award_id ]
  @fields_required [:voucher_id, :user_id, :award_id]

  @primary_key {:voucher_id, :string, autogenerate: false}
  
  schema "vouchers" do
    field :name,             :string
    belongs_to :users, UserSchema, foreign_key: :user_id, references: :user_id
    belongs_to :awards, AwardSchema, foreign_key: :award_id, references: :award_id
    field :code,             :string
    field :status,           :boolean,       default: false

    timestamps()
  end

  def changeset(%VoucherSchema{} = award, params \\ %{}) do
    award
    |> cast(params, @fields)
    |> validate_required(@fields_required)
  end

end