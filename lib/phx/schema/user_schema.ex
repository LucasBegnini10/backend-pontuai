defmodule Phx.Schema.UserSchema do 
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:user_id, :first_name, :last_name, :email, :document,  :code_reset_password, :inserted_at, :updated_at]}

  @fields [:user_id, :first_name, :last_name, :email, :document, :password, :code_reset_password, :is_admin]
  @fields_required [:user_id, :first_name, :email, :document, :password]

  @primary_key {:user_id, :string, autogenerate: false}
  
  schema "users" do
    field :first_name,             :string
    field :last_name,              :string
    field :email,                  :string
    field :document,               :string
    field :password,               :string
    field :code_reset_password,    :string
    field :is_admin,               :boolean,        default: false

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields_required)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email, :document])
  end

end