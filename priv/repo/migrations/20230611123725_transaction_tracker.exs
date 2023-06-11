defmodule Phx.Repo.Migrations.TransactionTracker do
  use Ecto.Migration

  def change do
    create table(:transaction_tracker, primary_key: false) do
      add :transaction_tracker_id, :string, primary_key: true
      add :points, :integer, null: false
      add :type, :boolean, null: false
      add :user_id, references(:users, column: :user_id, type: :string), null: false

      timestamps()
    end
  end
end
