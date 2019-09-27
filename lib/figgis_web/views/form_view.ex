defmodule FiggisWeb.FormView do
  @doc """
  Helper method for deciding the CSS class names to apply to a `<form`
  """
  @spec form_classes(Ecto.Changeset.t()) :: String.t()
  def form_classes(%{action: action} = _changeset) when is_nil(action) do
    "Form"
  end

  def form_classes(_changeset) do
    "Form is-error"
  end
end
