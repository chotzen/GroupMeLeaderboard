class AddLikesToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :likes, :integer
  end
end
