defmodule Phx.Repo.Migrations.CreateVoucher do
  use Ecto.Migration

  def change do
    create table(:vouchers, primary_key: false) do
      add :voucher_id, :string, primary_key: true
      add :user_id, references(:users, column: :user_id, type: :string), null: false
      add :award_id, references(:awards, column: :award_id, type: :string), null: false
      add :code, :string, null: false
      add :status, :boolean, default: false

      timestamps()
    end

    create index(:vouchers, [:user_id])
    create index(:vouchers, [:award_id])
  end
end
