defmodule Phx.Repo.Migrations.AddPointsInUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :points, :integer, after: :password, default: 0
    end
  end
end
