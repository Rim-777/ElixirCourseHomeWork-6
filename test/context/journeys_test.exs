defmodule Context.JourneysTest do
  use Context.DataCase
  import Ecto.Query, warn: false
  alias Context.Journeys
  alias Context.Places.Place

  describe "journeys" do
    alias Context.Journeys
    alias Context.Journeys.Journey
    alias Context.JourneysPlaces.JourneysPlace

    import Context.JourneysFixtures

    @invalid_attrs %{date: nil}

    test "get_journey!/1 returns the journey with given id" do
      journey = %Journey{id: journey_id} = journey_fixture()
      assert Journeys.get_journey!(journey_id) == journey
    end

    test "create_journey/1 with valid data creates a journey with associations" do
      date = ~N[2024-03-14 19:13:00]
      valencia_name = "Valencia"
      malaga_name = "Malaga"

      valid_attrs = %{
        date: date,
        places: %{
          0 => %{name: valencia_name},
          1 => %{name: malaga_name}
        }
      }

      assert {:ok, %Journey{id: journey_id, date: ^date, places: places}} =
               Journeys.create_journey(valid_attrs)

      assert JourneysPlace |> where(journey_id: ^journey_id) |> Repo.aggregate(:count, :id) == 2

      [
        %Place{name: ^valencia_name, id: valencia_id},
        %Place{name: ^malaga_name, id: malaga_id}
      ] =
        places

      assert where(Place, id: ^valencia_id, name: ^valencia_name) |> Repo.one()
      assert where(Place, id: ^malaga_id, name: ^malaga_name) |> Repo.one()
    end

    test "create_journey/1 with invalid data returns error changeset" do
      assert {:error,
              %Ecto.Changeset{
                errors: [
                  date: {"can't be blank", [validation: :required]},
                  places: {"can't be blank", [validation: :required]}
                ]
              }} = Journeys.create_journey(@invalid_attrs)
    end

    test "delete_journey/1 deletes the journey with associations" do
      journey = %Journey{id: journey_id} = journey_fixture()
      assert {:ok, %Journey{id: ^journey_id}} = Journeys.delete_journey(journey)
      assert_raise Ecto.NoResultsError, fn -> Journeys.get_journey!(journey_id) end

      assert JourneysPlace |> where(journey_id: ^journey_id) |> Repo.aggregate(:count, :id) == 0

      assert %Place{name: "Malaga"} = where(Place, name: "Malaga") |> Repo.one()
      assert %Place{name: "Valencia"} = where(Place, name: "Valencia") |> Repo.one()
    end
  end
end
