defmodule Cheffy.Foods.Calculations.IngredientEdibleByGuest do
  use Ash.Resource.Calculation

  require Ash.Query

  @impl true
  def load(_query, _opts, _context) do
    [:category]
  end

  @impl true
  def calculate(records, _opts, %{arguments: %{guest_id: guest_id}}) do
    guest =
      Cheffy.Foods.Guest
      |> Ash.Query.filter(id: guest_id)
      |> Ash.read_one!(load: :excluded_categories)

    guest_category_ids = Enum.map(guest.excluded_categories, & &1.id)

    Enum.map(records, fn record ->
      record.category.id not in guest_category_ids
    end)
  end
end
