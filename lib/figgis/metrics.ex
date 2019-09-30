defmodule Figgis.Metrics do
  @moduledoc """
  The Metrics context.
  """

  import Ecto.Query, warn: false
  alias Figgis.Repo

  alias Figgis.Metrics.Metric
  alias Figgis.Projects.Project

  @doc """
  Returns the list of metrics.

  ## Examples

      iex> list_metrics()
      [%Metric{}, ...]

  """
  def list_metrics do
    Repo.all(Metric)
  end

  @doc """
  Gets a single metric.

  Raises `Ecto.NoResultsError` if the Metric does not exist.

  ## Examples

      iex> get_metric!(123)
      %Metric{}

      iex> get_metric!(456)
      ** (Ecto.NoResultsError)

  """
  def get_metric!(id) do
    queryable =
      from m in Metric,
        where: m.id == ^id,
        order_by: [desc: m.inserted_at],
        preload: :data

    Repo.one!(queryable)
  end

  @doc """
  Creates a metric.

  ## Examples

      iex> create_metric(project, %{field: value})
      {:ok, %Metric{}}

      iex> create_metric(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_metric(%Project{} = project, attrs \\ %{}) do
    %Metric{}
    |> Metric.changeset(attrs)
    |> Ecto.Changeset.put_change(:project_id, project.id)
    |> Repo.insert()
  end

  @doc """
  Updates a metric.

  ## Examples

      iex> update_metric(project, metric, %{field: new_value})
      {:ok, %Metric{}}

      iex> update_metric(project, metric, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_metric(%Project{} = project, %Metric{} = metric, attrs) do
    metric
    |> Metric.changeset(attrs)
    |> Ecto.Changeset.put_change(:project_id, project.id)
    |> Repo.update()
  end

  @doc """
  Deletes a Metric.

  ## Examples

      iex> delete_metric(metric)
      {:ok, %Metric{}}

      iex> delete_metric(metric)
      {:error, %Ecto.Changeset{}}

  """
  def delete_metric(%Metric{} = metric) do
    Repo.delete(metric)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking metric changes.

  ## Examples

      iex> change_metric(metric)
      %Ecto.Changeset{source: %Metric{}}

  """
  def change_metric(%Metric{} = metric) do
    Metric.changeset(metric, %{})
  end

  alias Figgis.Metrics.Datum

  @doc """
  Returns the list of data.

  ## Examples

      iex> list_data()
      [%Datum{}, ...]

  """
  def list_data do
    Repo.all(Datum)
  end

  @doc """
  Gets a single datum.

  Raises `Ecto.NoResultsError` if the Datum does not exist.

  ## Examples

      iex> get_datum!(123)
      %Datum{}

      iex> get_datum!(456)
      ** (Ecto.NoResultsError)

  """
  def get_datum!(id), do: Repo.get!(Datum, id)

  @doc """
  Creates a datum.

  ## Examples

      iex> create_datum(metric, %{field: value})
      {:ok, %Datum{}}

      iex> create_datum(metric, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_datum(%Metric{} = metric, attrs \\ %{}) do
    %Datum{}
    |> Datum.changeset(attrs)
    |> Ecto.Changeset.put_change(:metric_id, metric.id)
    |> Repo.insert()
  end

  @doc """
  Updates a datum.

  ## Examples

      iex> update_datum(metric, datum, %{field: new_value})
      {:ok, %Datum{}}

      iex> update_datum(metric, datum, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_datum(%Metric{} = metric, %Datum{} = datum, attrs) do
    datum
    |> Datum.changeset(attrs)
    |> Ecto.Changeset.put_change(:metric_id, metric.id)
    |> Repo.update()
  end

  @doc """
  Deletes a Datum.

  ## Examples

      iex> delete_datum(datum)
      {:ok, %Datum{}}

      iex> delete_datum(datum)
      {:error, %Ecto.Changeset{}}

  """
  def delete_datum(%Datum{} = datum) do
    Repo.delete(datum)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking datum changes.

  ## Examples

      iex> change_datum(datum)
      %Ecto.Changeset{source: %Datum{}}

  """
  def change_datum(%Datum{} = datum) do
    Datum.changeset(datum, %{})
  end
end
