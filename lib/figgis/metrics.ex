defmodule Figgis.Metrics do
  @moduledoc """
  The Metrics context.
  """

  import Ecto.Query, warn: false
  alias Figgis.Repo

  alias Figgis.Metrics.Metric

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
  def get_metric!(id), do: Repo.get!(Metric, id)

  @doc """
  Creates a metric.

  ## Examples

      iex> create_metric(%{field: value})
      {:ok, %Metric{}}

      iex> create_metric(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_metric(attrs \\ %{}) do
    %Metric{}
    |> Metric.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a metric.

  ## Examples

      iex> update_metric(metric, %{field: new_value})
      {:ok, %Metric{}}

      iex> update_metric(metric, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_metric(%Metric{} = metric, attrs) do
    metric
    |> Metric.changeset(attrs)
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

      iex> create_datum(%{field: value})
      {:ok, %Datum{}}

      iex> create_datum(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_datum(attrs \\ %{}) do
    %Datum{}
    |> Datum.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a datum.

  ## Examples

      iex> update_datum(datum, %{field: new_value})
      {:ok, %Datum{}}

      iex> update_datum(datum, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_datum(%Datum{} = datum, attrs) do
    datum
    |> Datum.changeset(attrs)
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