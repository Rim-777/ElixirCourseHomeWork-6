defmodule Context.Journeys do
  @moduledoc """
  The Journeys context.
  """

  import Ecto.Query, warn: false
  alias Context.Repo

  alias Context.Journeys.Journey

  @doc """
  Gets a single journey.

  Raises `Ecto.NoResultsError` if the Journey does not exist.

  ## Examples

      iex> get_journey!(123)
      %Journey{}

      iex> get_journey!(456)
      ** (Ecto.NoResultsError)

  """
  def get_journey!(id) do
    Journey
    |> preload([:places])
    |> Repo.get!(id)
  end

  @doc """
  Creates a journey.

  ## Examples

      iex> create_journey(%{field: value})
      {:ok, %Journey{}}

      iex> create_journey(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_journey(attrs \\ %{}) do
    %Journey{}
    |> Journey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a journey.

  ## Examples

      iex> delete_journey(journey)
      {:ok, %Journey{}}

      iex> delete_journey(journey)
      {:error, %Ecto.Changeset{}}

  """
  def delete_journey(%Journey{} = journey) do
    Repo.delete(journey)
  end
end
