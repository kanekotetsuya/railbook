class ChangeTableToBooks < ActiveRecord::Migration[5.1]
  def change
    change_table :books do |t|
      t.string :author
      t.index :title
    end
  end
end
