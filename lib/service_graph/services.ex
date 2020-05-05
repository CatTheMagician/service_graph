defmodule ServiceGraph.Services do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  alias ServiceGraph.Repo

  alias ServiceGraph.Services.Service
  alias ServiceGraph.Consumes.Consume

  def consumes_count(service_name) do
    from(c in Consume)
    |> where([c], c.external_service == ^service_name)
    |> select([c], count(c))
    |> Repo.one()
  end

  @doc """
  Returns the list of services.

  ## Examples

      iex> list_services()
      [%Service{}, ...]

  """
  def list_services do
    from(s in Service)
    |> order_by([s], asc: s.title)
    |> select([s], s)
    |> Repo.all()
  end

  def list_services_with_consumes_count do
    from(s in Service)
    |> join(:left, [s], c in Consume, on: c.external_service == s.title)
    |> group_by([s, c], s.title)
    |> order_by([s, c], asc: s.title)
    |> select([s, c], {s.title, count(c)})
    |> Repo.all()
  end

  @doc """
  Gets a single service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

      iex> get_service!(123)
      %Service{}

      iex> get_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service!(id), do: Repo.get!(Service, id)
  def get_service(id), do: Repo.get(Service, id)

  def get_service_by_title(title), do: Repo.get_by(Service, %{title: title})

  @doc """
  Creates a service.

  ## Examples

      iex> create_service(%{field: value})
      {:ok, %Service{}}

      iex> create_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service.

  ## Examples

      iex> update_service(service, %{field: new_value})
      {:ok, %Service{}}

      iex> update_service(service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a service.

  ## Examples

      iex> delete_service(service)
      {:ok, %Service{}}

      iex> delete_service(service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  def delete_service_by_title(service_title) do
    from(s in Service)
    |> where([s], s.title == ^service_title)
    |> Repo.delete_all()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service changes.

  ## Examples

      iex> change_service(service)
      %Ecto.Changeset{source: %Service{}}

  """
  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end
end
