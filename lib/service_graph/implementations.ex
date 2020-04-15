defmodule ServiceGraph.Implementations do
  @moduledoc """
  The Implementations context.
  """

  import Ecto.Query, warn: false
  alias ServiceGraph.Repo

  alias ServiceGraph.Implementations.Implementation

  @doc """
  Returns the list of implementations.

  ## Examples

      iex> list_implementations()
      [%Implementation{}, ...]

  """
  def list_implementations do
    Repo.all(Implementation)
  end

  @doc """
  Gets a single implementation.

  Raises `Ecto.NoResultsError` if the Implementation does not exist.

  ## Examples

      iex> get_implementation!(123)
      %Implementation{}

      iex> get_implementation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_implementation!(id), do: Repo.get!(Implementation, id)

  def get_implementation_by_service_id_and_action_name(service_id, action_name) do
    Repo.get_by(Implementation, %{service_id: service_id, action_name: action_name})
  end

  @doc """
  Creates a implementation.

  ## Examples

      iex> create_implementation(%{field: value})
      {:ok, %Implementation{}}

      iex> create_implementation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_implementation(attrs \\ %{}) do
    %Implementation{}
    |> Implementation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a implementation.

  ## Examples

      iex> update_implementation(implementation, %{field: new_value})
      {:ok, %Implementation{}}

      iex> update_implementation(implementation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_implementation(%Implementation{} = implementation, attrs) do
    implementation
    |> Implementation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a implementation.

  ## Examples

      iex> delete_implementation(implementation)
      {:ok, %Implementation{}}

      iex> delete_implementation(implementation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_implementation(%Implementation{} = implementation) do
    Repo.delete(implementation)
  end

  def delete_implementations_by_service_id(id) do
    query = from(t in Implementation, where: t.service_id == ^id)

    Repo.delete_all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking implementation changes.

  ## Examples

      iex> change_implementation(implementation)
      %Ecto.Changeset{source: %Implementation{}}

  """
  def change_implementation(%Implementation{} = implementation) do
    Implementation.changeset(implementation, %{})
  end
end
