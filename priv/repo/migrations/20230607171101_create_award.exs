defmodule Phx.Repo.Migrations.CreateAward do
  use Ecto.Migration

  def change do
    create table(:awards, primary_key: false) do
      add :award_id, :string, primary_key: true
      add :name, :string, null: false
      add :points, :integer, null: false
      add :description, :string
      add :status, :boolean, default: true

      timestamps()
    end
  end
end
