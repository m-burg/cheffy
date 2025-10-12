defmodule Cheffy.Foods.Calculations.RecipeEdibleByGuest do
  use Ash.Resource.Calculation

  @impl true
  def load(_query, _opts, %{arguments: %{guest_id: guest_id}}) do
    [components: [edible_by_guest: [guest_id: guest_id]]]
  end

  @impl true
  def calculate(records, _opts, _context) do
    Enum.map(records, fn record ->
      Enum.all?(record.components, & &1.edible_by_guest)
    end)
  end
end
