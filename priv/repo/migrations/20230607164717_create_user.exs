defmodule Phx.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :user_id, :string, primary_key: true
      add :first_name, :string, null: false
      add :last_name, :string
      add :email, :string, null: false, unique: true
      add :document, :string, null: false, unique: true
      add :password, :string, null: false
      add :code_reset_password, :string
      add :is_admin, :boolean, default: false

      timestamps()
    end

    create index(:users, [:email])
    create index(:users, [:document])
  end

end
