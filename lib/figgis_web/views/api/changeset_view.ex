defmodule FiggisWeb.Api.ChangesetView do
  alias Ecto.Changeset

  import FiggisWeb.ErrorHelpers, only: [translate_error: 1]

  @doc """
  Renders a JSON:API error object for a changeset with errors
  """
  def invalid_record(%Changeset{} = changeset) do
    errors =
      changeset
      |> translate_errors()
      |> errors_from_changeset()

    %{errors: errors}
  end

  # See FiggisWeb.ErrorHelpers.translate_error/1
  defp translate_errors(%Changeset{} = changeset) do
    Changeset.traverse_errors(changeset, &translate_error/1)
  end

  defp camelize(form) when is_binary(form) do
    Inflex.camelize(form, :lower)
  end

  defp camelize(form) do
    form
    |> Atom.to_string()
    |> camelize()
  end

  defp errors_from_changeset(errors) do
    errors
    |> Enum.sort()
    |> Enum.map(fn {attr, msgs} ->
      %{
        status: "422",
        source: %{
          pointer: "/data/attributes/#{camelize(attr)}"
        },
        title: "Invalid attribute",
        detail: Enum.join(msgs, ", ")
      }
    end)
  end
end
