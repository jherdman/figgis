defmodule Figgis.Metrics.Metric do
  @moduledoc """
  Each Metric is a collection of Data. It describes the nature of said Data.
  """

  use Figgis.Schema
  import Ecto.Changeset

  alias Figgis.Metrics.Datum
  alias Figgis.Projects.Project

  schema "metrics" do
    field :description, :string
    field :name, :string
    field :x_axis_label, :string
    field :x_axis_type, :string
    field :y_axis_label, :string
    field :y_axis_type, :string

    belongs_to :project, Project

    has_many :data, Datum, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(metric, attrs) do
    metric
    |> cast(attrs, [
      :name,
      :description,
      :x_axis_label,
      :x_axis_type,
      :y_axis_label,
      :y_axis_type,
      :project_id
    ])
    |> validate_required([
      :name,
      :description,
      :x_axis_label,
      :x_axis_type,
      :y_axis_label,
      :y_axis_type
    ])
    |> foreign_key_constraint(:project_id)
  end
end
