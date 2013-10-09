class AddUniqueIndexToOrganisationApiid < ActiveRecord::Migration
  def change
    change_column :organisations, :api_id, :string
    add_index :organisations, :api_id, unique: true
  end
end
