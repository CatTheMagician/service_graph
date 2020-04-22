defmodule ServiceGraph.Consumes do
  @moduledoc """
  The Consumes context.
  """

  import Ecto.Query, warn: false
  alias ServiceGraph.Repo

  alias ServiceGraph.Consumes.Consume

  @doc """
  Returns the list of consumes.

  ## Examples

      iex> list_consumes()
      [%Consume{}, ...]

  """
  def list_consumes do
    Repo.all(Consume)
  end

  def get_consume_by_service_and_action_name(service, ext_service, ext_action) do
    Repo.get_by(Consume, %{
      service: service,
      external_service: ext_service,
      external_action_name: ext_action
    })
  end

  @doc """
  Gets a single consume.

  Raises `Ecto.NoResultsError` if the Consume does not exist.

  ## Examples

      iex> get_consume!(123)
      %Consume{}

      iex> get_consume!(456)
      ** (Ecto.NoResultsError)

  """
  def get_consume!(id), do: Repo.get!(Consume, id)

  @doc """
  Creates a consume.

  ## Examples

      iex> create_consume(%{field: value})
      {:ok, %Consume{}}

      iex> create_consume(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_consume(attrs \\ %{}) do
    %Consume{}
    |> Consume.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a consume.

  ## Examples

      iex> update_consume(consume, %{field: new_value})
      {:ok, %Consume{}}

      iex> update_consume(consume, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_consume(%Consume{} = consume, attrs) do
    consume
    |> Consume.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a consume.

  ## Examples

      iex> delete_consume(consume)
      {:ok, %Consume{}}

      iex> delete_consume(consume)
      {:error, %Ecto.Changeset{}}

  """
  def delete_consume(%Consume{} = consume) do
    Repo.delete(consume)
  end

  def delete_consumes_by_service_name(title) do
    query = from(t in Consume, where: t.service == ^title)

    Repo.delete_all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking consume changes.

  ## Examples

      iex> change_consume(consume)
      %Ecto.Changeset{source: %Consume{}}

  """
  def change_consume(%Consume{} = consume) do
    Consume.changeset(consume, %{})
  end
end
