defmodule Cheffy.Foods do
  use Ash.Domain,
    otp_app: :cheffy,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Cheffy.Foods.Ingredient do
      define :create_ingredient, action: :create
    end

    resource Cheffy.Foods.Recipe do
      define :create_recipe, action: :create
    end

    resource Cheffy.Foods.RecipeComponent do
      define :create_recipe_component, action: :create
    end

    resource Cheffy.Foods.IngredientCategory do
      define :create_ingredient_category, action: :create
    end

    resource Cheffy.Foods.Guest do
      define :create_guest, action: :create
    end

    resource Cheffy.Foods.GuestExcludedCategory do
      define :create_guest_excluded_category, action: :create
    end

    resource Cheffy.Foods.ComponentSubstitute do
      define :create_component_substitute, action: :create
    end
  end
end
