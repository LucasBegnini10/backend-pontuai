defmodule Phx.Schema.UserSchema do 
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Phx.Repo
  alias Phx.Schema.UserSchema

  @derive {Jason.Encoder, only: [:user_id, :first_name, :last_name, :email, :document, :points,  :code_reset_password, :inserted_at, :updated_at]}

  @fields [:user_id, :first_name, :last_name, :email, :document, :password, :points, :code_reset_password, :is_admin]
  @fields_required [:user_id, :first_name, :email, :document, :password]

  @primary_key {:user_id, :string, autogenerate: false}
  
  schema "users" do
    field :first_name,             :string
    field :last_name,              :string
    field :email,                  :string
    field :document,               :string
    field :password,               :string
    field :points,                 :integer
    field :code_reset_password,    :string
    field :is_admin,               :boolean,        default: false

    timestamps()
  end

  def changeset(%UserSchema{} = user, params \\ %{}, type) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields_required)
    |> validate_format(:email, ~r/^[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+$/i)
    |> unique_email_document_constraint(type)
  end


  defp unique_email_document_constraint(changeset, type) when type == :create do
    email = get_change(changeset, :email)
    document = get_change(changeset, :document)
  
    case Repo.one(from(u in UserSchema, where: u.email == ^email)) do
      nil ->
        case Repo.one(from(u in UserSchema, where: u.document == ^document)) do
          nil -> changeset
          _ -> add_error(changeset, :document, "has already been taken")
        end
      _ -> add_error(changeset, :email, "has already been taken")
    end
  end

  defp unique_email_document_constraint(changeset, type) when type == :update do
  email = get_change(changeset, :email)
  document = get_change(changeset, :document)

  if email != nil do
    case Repo.one(from(u in UserSchema, where: u.email == ^email)) do
      nil ->
        if document != nil do
          case Repo.one(from(u in UserSchema, where: u.document == ^document)) do
            nil -> changeset
            _ -> add_error(changeset, :document, "has already been taken")
          end
        else
          changeset
        end
      _ -> add_error(changeset, :email, "has already been taken")
    end
  else
    if document != nil do
      case Repo.one(from(u in UserSchema, where: u.document == ^document)) do
        nil -> changeset
        _ -> add_error(changeset, :document, "has already been taken")
      end
    else
      changeset
    end
  end
end
end