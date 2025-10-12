defmodule Cheffy.Foods.IngredientCategory do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "ingredient_categories"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:name]
    end

    update :update do
      accept [:name]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      allow_nil? false
    end
  end

  relationships do
    has_many :exclusion_relationships, Cheffy.Foods.GuestExcludedCategory

    many_to_many :excluded_guests, Cheffy.Foods.Guest do
      join_relationship :exclusion_relationships
      destination_attribute_on_join_resource :guest_id
    end

    has_many :ingredients, Cheffy.Foods.Ingredient do
      destination_attribute :ingredient_category_id
      public? true
    end
  end
end
