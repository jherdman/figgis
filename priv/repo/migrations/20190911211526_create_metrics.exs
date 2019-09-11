defmodule Figgis.Repo.Migrations.CreateMetrics do
  use Ecto.Migration

  def change do
    create table(:metrics, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")

      add :name, :string, null: false
      add :description, :string
      add :x_axis_label, :string, null: false
      add :x_axis_type, :string, null: false
      add :y_axis_label, :string, null: false
      add :y_axis_type, :string, null: false

      add :project_id, references(:projects, on_delete: :delete_all, type: :binary_id),
        null: false

      timestamps()
    end

    create index(:metrics, [:project_id])
  end
end
