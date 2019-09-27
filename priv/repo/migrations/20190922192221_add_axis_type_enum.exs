defmodule Figgis.Repo.Migrations.AddAxisTypeEnum do
  use Ecto.Migration

  def change do
    AxisTypes.create_type()

    alter table(:metrics) do
      remove :x_axis_type
      remove :y_axis_type

      add :x_axis_type, AxisTypes.type()
      add :y_axis_type, AxisTypes.type()
    end
  end
end
