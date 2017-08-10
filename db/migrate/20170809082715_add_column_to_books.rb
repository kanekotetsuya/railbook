class AddColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :publish, :string
    add_column :books, :dl, :boolean
  end
end
