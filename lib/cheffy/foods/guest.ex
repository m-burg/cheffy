defmodule Cheffy.Foods.Guest do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "guests"
    repo Cheffy.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      allow_nil? false
    end
  end

  relationships do
    has_many :exclusion_relationships, Cheffy.Foods.GuestExcludedCategory do
      destination_attribute :guest_id
    end

    many_to_many :excluded_categories, Cheffy.Foods.IngredientCategory do
      join_relationship :exclusion_relationships
      source_attribute_on_join_resource :guest_id
    end
  end
end
