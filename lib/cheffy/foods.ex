defmodule Cheffy.Foods do
  use Ash.Domain,
    otp_app: :cheffy

  resources do
    resource Cheffy.Foods.Ingredient
    resource Cheffy.Foods.Recipe
    resource Cheffy.Foods.RecipeComponent
    resource Cheffy.Foods.IngredientCategory
  end
end
