class AddRealNameToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :real_name, :string
  end
end
