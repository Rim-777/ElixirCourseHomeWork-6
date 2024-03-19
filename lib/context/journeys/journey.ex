defmodule Context.Journeys.Journey do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "journeys" do
    field :date, :naive_datetime

    many_to_many :places,
                 Context.Places.Place,
                 join_through: Context.JourneysPlaces.JourneysPlace

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(journey, attrs) do
    journey
    |> cast(attrs, [:date])
    |> cast_assoc(:places, required: true)
    |> validate_required([:date])
  end
end
