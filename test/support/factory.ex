defmodule Figgis.Factory do
  @moduledoc """
  Integration module for ExMachina.
  """

  use ExMachina.Ecto, repo: Figgis.Repo

  def project_factory do
    %Figgis.Projects.Project{
      name: "Avro"
    }
  end

  def metric_factory do
    %Figgis.Metrics.Metric{
      name: "CSS Bundle Size",
      x_axis_label: "Date",
      x_axis_type: "date",
      y_axis_label: "Kilobytes",
      y_axis_type: "number",
      project: build(:project)
    }
  end

  def datum_factory do
    %Figgis.Metrics.Datum{
      x_value: "2019-05-16 10:30:00",
      y_value: "1123",
      metric: build(:metric)
    }
  end
end
