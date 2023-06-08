defmodule Phx.Schema.UserSchema do 
  use Ecto.Schema
  import Ecto.Changeset
  alias Phx.Repo
  
  alias Phx.Schema.UserSchema

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

  def changeset(%UserSchema{} = user, params \\ %{}) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields_required)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, name: :users_email_index)
    |> unique_constraint(:document, name: :users_document_index)
    |> unique_email_document_constraint()
  end

  defp unique_email_document_constraint(changeset) do
    email = get_change(changeset, :email)
    document = get_change(changeset, :document)
  
    case Repo.get_by(UserSchema, email: email) do
      nil ->
        case Repo.get_by(UserSchema, document: document) do
          nil -> changeset
          _ -> add_error(changeset, :document, "has already been taken")
        end
      _ -> add_error(changeset, :email, "has already been taken")
    end
  end

end