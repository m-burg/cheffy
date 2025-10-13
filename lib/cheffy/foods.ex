defmodule Cheffy.Foods do
  use Ash.Domain,
    otp_app: :cheffy,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Cheffy.Foods.Ingredient
    resource Cheffy.Foods.Recipe
    resource Cheffy.Foods.RecipeComponent
    resource Cheffy.Foods.IngredientCategory
    resource Cheffy.Foods.Guest
    resource Cheffy.Foods.GuestExcludedCategory
    resource Cheffy.Foods.ComponentSubstitute
  end
end
