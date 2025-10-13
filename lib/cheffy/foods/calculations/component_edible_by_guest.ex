defmodule Cheffy.Foods.Calculations.ComponentEdibleByGuest do
  use Ash.Resource.Calculation

  @impl true
  def load(_query, _opts, %{arguments: %{guest_id: guest_id}}) do
    [
      ingredient: [edible_by_guest: [guest_id: guest_id]],
      substitutes: [edible_by_guest: [guest_id: guest_id]]
    ]
  end

  @impl true
  def calculate(records, _opts, _context) do
    Enum.map(records, fn record ->
      record.ingredient.edible_by_guest or
        Enum.any?(record.substitutes, fn substitute -> substitute.edible_by_guest end)
    end)
  end
end
