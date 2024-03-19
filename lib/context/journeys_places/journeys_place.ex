defmodule Context.JourneysPlaces.JourneysPlace do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "journeys_places" do
    belongs_to :place, Context.Places.Place
    belongs_to :journey, Context.Journeys.Journey

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(journeys_place, attrs) do
    fields = [:place_id, :journey_id]

    journeys_place
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> unique_constraint(fields)
  end
end
