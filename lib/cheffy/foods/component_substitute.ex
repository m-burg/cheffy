defmodule Cheffy.Foods.ComponentSubstitute do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "component_substitutes"
    repo Cheffy.Repo
  end
end
