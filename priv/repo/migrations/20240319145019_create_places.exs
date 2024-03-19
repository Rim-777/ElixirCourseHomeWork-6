defmodule Context.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
