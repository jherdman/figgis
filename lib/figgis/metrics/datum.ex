defmodule Figgis.Metrics.Datum do
  @moduledoc """
  Represents a recording for a given Metric.
  """

  use Figgis.Schema
  import Ecto.Changeset

  alias Figgis.Metrics.Metric

  schema "data" do
    field :x_value, :string
    field :y_value, :string

    belongs_to :metric, Metric

    timestamps()
  end

  @doc false
  def changeset(datum, attrs) do
    datum
    |> cast(attrs, [:x_value, :y_value, :metric_id])
    |> validate_required([:x_value, :y_value, :metric_id])
  end
end
