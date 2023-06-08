defmodule Phx.Repository.UserRepository do 
  import Ecto.Query
  alias Phx.Repo
  alias Phx.Schema.UserSchema

  def create(attrs \\ %{}) do 
    try do
      %UserSchema{}
      |> UserSchema.changeset(attrs)
      |> Repo.insert()
    rescue e ->
      IO.inspect(e, label: "Create User ===>")
    end 
  end

  def get(user_id) do 
    try do 
      Repo.get_by(UserSchema, user_id: user_id)
    rescue e -> 
      IO.inspect(e, label: "Get User ===>")
      {:error, e}
    end
  end

  def update(user_id, attrs \\ %{}) do 
    try do 
      Repo.get_by!(UserSchema, user_id: user_id)
      |> UserSchema.changeset(attrs)
      |> Repo.update()
    rescue e -> 
      IO.inspect(e, label: "Update User ===>")
      {:error, e}
    end
  end

  def delete(user_id) do 
    try do 
      Repo.get_by!(UserSchema, user_id: user_id)
      |> Repo.delete()
    rescue e ->
      IO.inspect(e, label: "Delete User ==>")
      {:error, e}
    end
  end

  def get_by_email(email) do 
    try do 
      Repo.get_by(UserSchema, email: email)
    rescue e -> 
      IO.inspect(e, label: "Get User by email ===>")
      {:error, e}
    end
  end

  def get_by_document(document) do 
    try do 
      Repo.get_by(UserSchema, document: document)
    rescue e -> 
      IO.inspect(e, label: "Get User by document ===>")
      {:error, e}
    end
  end

  def get_by_email_or_document(indentifier) do
    try do 
      query = from u in UserSchema, 
      where: u.document == ^indentifier,
      or_where: u.email == ^indentifier

      Repo.one(query)
    rescue e -> 
      IO.inspect(e, label: "Get User by email or document ===>")
      {:error, e}
    end
  end


end