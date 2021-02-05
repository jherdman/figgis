defmodule Figgis.MetricsTest do
  use Figgis.DataCase

  alias Figgis.{Factory, Metrics}

  describe "metrics" do
    alias Figgis.Metrics.Metric

    @valid_attrs %{
      description: "some description",
      name: "some name",
      x_axis_label: "some x_axis_label",
      x_axis_type: "date",
      y_axis_label: "some y_axis_label",
      y_axis_type: "number"
    }
    @update_attrs %{
      description: "some updated description",
      name: "some updated name",
      x_axis_label: "some updated x_axis_label",
      x_axis_type: "number",
      y_axis_label: "some updated y_axis_label",
      y_axis_type: "date"
    }
    @invalid_attrs %{
      description: nil,
      name: nil,
      x_axis_label: nil,
      x_axis_type: nil,
      y_axis_label: nil,
      y_axis_type: nil
    }

    test "list_metrics/0 returns all metrics" do
      metric = Factory.insert(:metric)

      metrics = Metrics.list_metrics()
      metric_ids = Enum.map(metrics, fn metric -> metric.id end)

      assert metric_ids == [metric.id]
    end

    test "get_metric!/1 returns the metric with given id" do
      metric = Factory.insert(:metric)
      found_metric = Metrics.get_metric!(metric.id)

      assert found_metric.id == metric.id
    end

    test "create_metric/1 with valid data creates a metric" do
      project = Factory.insert(:project)

      assert {:ok, %Metric{} = metric} = Metrics.create_metric(project, @valid_attrs)

      assert metric.project_id == project.id
      assert metric.description == "some description"
      assert metric.name == "some name"
      assert metric.x_axis_label == "some x_axis_label"
      assert metric.x_axis_type == :date
      assert metric.y_axis_label == "some y_axis_label"
      assert metric.y_axis_type == :number
    end

    test "create_metric/1 with invalid data returns error changeset" do
      project = Factory.insert(:project)

      assert {:error, %Ecto.Changeset{}} = Metrics.create_metric(project, @invalid_attrs)
    end

    test "update_metric/2 with valid data updates the metric" do
      metric = Factory.insert(:metric)
      project = metric.project

      assert {:ok, %Metric{} = metric} = Metrics.update_metric(project, metric, @update_attrs)
      assert metric.description == "some updated description"
      assert metric.name == "some updated name"
      assert metric.x_axis_label == "some updated x_axis_label"
      assert metric.x_axis_type == :number
      assert metric.y_axis_label == "some updated y_axis_label"
      assert metric.y_axis_type == :date
    end

    test "update_metric/2 with invalid data returns error changeset" do
      metric = Factory.insert(:metric)
      project = metric.project

      assert {:error, %Ecto.Changeset{}} = Metrics.update_metric(project, metric, @invalid_attrs)

      found_metric = Metrics.get_metric!(metric.id)

      assert metric.name == found_metric.name
    end

    test "delete_metric/1 deletes the metric" do
      metric = Factory.insert(:metric)
      assert {:ok, %Metric{}} = Metrics.delete_metric(metric)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_metric!(metric.id) end
    end

    test "delete_metric/1 deletes associated data" do
      metric = Factory.insert(:metric)

      inserted_data = Factory.insert_list(4, :datum, metric: metric)

      assert Enum.count(inserted_data) === 4

      Metrics.delete_metric(metric)

      data = Metrics.list_data(metric)

      assert Enum.count(data) === 0
    end

    test "change_metric/1 returns a metric changeset" do
      metric = Factory.insert(:metric)
      assert %Ecto.Changeset{} = Metrics.change_metric(metric)
    end
  end

  describe "data" do
    alias Figgis.Metrics.Datum

    @valid_attrs %{x_value: "some x_value", y_value: "some y_value"}
    @update_attrs %{x_value: "some updated x_value", y_value: "some updated y_value"}
    @invalid_attrs %{x_value: nil, y_value: nil}

    test "list_data/1 returns all data" do
      metric = Factory.insert(:metric)
      datum = Factory.insert(:datum, %{metric: metric})

      data = Metrics.list_data(metric)
      data_ids = Enum.map(data, fn datum -> datum.id end)

      assert data_ids == [datum.id]
    end

    test "get_datum!/1 returns the datum with given id" do
      datum = Factory.insert(:datum)

      assert Metrics.get_datum!(datum.id).id == datum.id
    end

    test "create_datum/1 with valid data creates a datum" do
      metric = Factory.insert(:metric)

      assert {:ok, %Datum{} = datum} = Metrics.create_datum(metric, @valid_attrs)

      assert datum.x_value == "some x_value"
      assert datum.y_value == "some y_value"
      assert datum.metric_id == metric.id
    end

    test "create_datum/1 with invalid data returns error changeset" do
      metric = Factory.insert(:metric)

      assert {:error, %Ecto.Changeset{}} = Metrics.create_datum(metric, @invalid_attrs)
    end

    test "update_datum/2 with valid data updates the datum" do
      metric = Factory.insert(:metric)
      datum = Factory.insert(:datum, %{metric: metric})

      assert {:ok, %Datum{} = datum} = Metrics.update_datum(metric, datum, @update_attrs)
      assert datum.x_value == "some updated x_value"
      assert datum.y_value == "some updated y_value"
    end

    test "update_datum/2 with invalid data returns error changeset" do
      metric = Factory.insert(:metric)
      datum = Factory.insert(:datum, %{metric: metric})

      assert {:error, %Ecto.Changeset{}} = Metrics.update_datum(metric, datum, @invalid_attrs)

      refound_datum = Metrics.get_datum!(datum.id)

      assert datum.x_value == refound_datum.x_value
      assert datum.y_value == refound_datum.y_value
    end

    test "delete_datum/1 deletes the datum" do
      datum = Factory.insert(:datum)
      assert {:ok, %Datum{}} = Metrics.delete_datum(datum)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_datum!(datum.id) end
    end

    test "change_datum/1 returns a datum changeset" do
      datum = Factory.insert(:datum)
      assert %Ecto.Changeset{} = Metrics.change_datum(datum)
    end
  end
end
