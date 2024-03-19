defmodule Context.JourneysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Context.Journeys` context.
  """

  @doc """
  Generate a journey.
  """
  def journey_fixture(attrs \\ %{}) do
    {:ok, journey} =
      attrs
      |> Enum.into(%{
        date: ~N[2024-03-14 19:13:00],
        places: %{
          0 => %{name: "Valencia"},
          1 => %{name: "Malaga"}
        }
      })
      |> Context.Journeys.create_journey()

    journey
  end
end
