defmodule Cheffy.RecipTest do
  use Cheffy.DataCase

  alias Cheffy.Foods

  require Ash.Query

  setup do
    gluten = Foods.create_ingredient_category!(%{name: "gluten"})
    gluten_free = Foods.create_ingredient_category!(%{name: "gluten free"})

    wheat_flour =
      Foods.create_ingredient!(%{name: "wheat flour", ingredient_category_id: gluten.id})

    buckwheat_flour =
      Foods.create_ingredient!(%{name: "buckwheat flour", ingredient_category_id: gluten_free.id})

    pancakes = Foods.create_recipe!(%{name: "pancakes"})

    flour_component =
      Foods.create_recipe_component!(%{recipe_id: pancakes.id, ingredient_id: wheat_flour.id})

    _wheat_substitute =
      Foods.create_component_substitute!(%{
        recipe_component_id: flour_component.id,
        ingredient_id: buckwheat_flour.id
      })

    gluten_free_guest = Foods.create_guest!(%{name: "cannot eat gluten"})

    _gluten_free_exclusion =
      Foods.create_guest_excluded_category!(%{
        guest_id: gluten_free_guest.id,
        ingredient_category_id: gluten.id
      })

    {:ok, gluten_free_guest: gluten_free_guest}
  end

  test "should be possible to load the edible calculation en Recipe", context do
    guest = context[:gluten_free_guest]

    assert hd(Ash.read!(Foods.Recipe, load: [edible_by_guest: [guest_id: guest.id]])).edible_by_guest
  end

  test "should be able to filter recipes based on edible calculation", context do
    guest = context[:gluten_free_guest]

    query =
      Foods.Recipe
      |> Ash.Query.filter(edible_by_guest(guest_id: ^guest.id))

    assert length(Ash.read!(query)) == 1
  end

  test "should be able to load the edible calculation on Ingredient", context do
    guest = context[:gluten_free_guest]

    [buckwheat] =
      Foods.Ingredient
      |> Ash.Query.filter(name: "buckwheat flour")
      |> Ash.read!(load: [edible_by_guest: [guest_id: guest.id]])

    assert buckwheat.edible_by_guest

    [wheat_flour] =
      Foods.Ingredient
      |> Ash.Query.filter(name: "wheat flour")
      |> Ash.read!(load: [edible_by_guest: [guest_id: guest.id]])

    refute wheat_flour.edible_by_guest
  end

  test "should be able to filter on the edible calculation on Ingredient", context do
    guest = context[:gluten_free_guest]

    query =
      Foods.Ingredient
      |> Ash.Query.filter(edible_by_guest(guest_id: ^guest.id))

    assert length(Ash.read!(query, load: [edible_by_guest: [guest_id: guest.id]])) == 1
  end

  test "should be able to load the edible calculation on RecipeComponent", context do
    guest = context[:gluten_free_guest]

    assert length(Ash.read!(Foods.RecipeComponent, load: [edible_by_guest: [guest_id: guest.id]])) ==
             1
  end

  test "should be able to filter RecipeComponent on calculation", context do
    guest = context[:gluten_free_guest]

    query =
      Foods.RecipeComponent
      |> Ash.Query.filter(edible_by_guest(guest_id: ^guest.id))

    assert length(Ash.read!(query)) == 1
  end
end
