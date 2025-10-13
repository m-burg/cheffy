# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cheffy.Repo.insert!(%Cheffy.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cheffy.Foods

gluten = Foods.create_ingredient_category!(%{name: "gluten"})
gluten_free = Foods.create_ingredient_category!(%{name: "gluten free"})

wheat_flour = Foods.create_ingredient!(%{name: "wheat flour", ingredient_category_id: gluten.id})

buckwheat_flour =
  Foods.create_ingredient!(%{name: "buckwheat flour", ingredient_category_id: gluten_free.id})

pancakes = Foods.create_recipe!(%{name: "pancakes"})

flour_component =
  Foods.create_recipe_component!(%{recipe_id: pancakes.id, ingredient_id: wheat_flour.id})

wheat_substitute =
  Foods.create_component_substitute!(%{
    recipe_component_id: flour_component.id,
    ingredient_id: buckwheat_flour.id
  })

gluten_free_guest = Foods.create_guest!(%{name: "cannot eat gluten"})

gluten_free_exclusion =
  Foods.create_guest_excluded_category!(%{
    guest_id: gluten_free_guest.id,
    ingredient_category_id: gluten.id
  })
