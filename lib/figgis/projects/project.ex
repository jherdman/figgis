defmodule Figgis.Projects.Project do
  @moduledoc """
  A Project collects many Metrics.
  """

  use Figgis.Schema
  import Ecto.Changeset

  alias Figgis.Metrics.Metric

  schema "projects" do
    field :name, :string

    has_many :metrics, Metric, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
