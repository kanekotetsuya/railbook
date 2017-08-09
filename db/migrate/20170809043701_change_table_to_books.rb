class ChangeTableToBooks < ActiveRecord::Migration[5.1]
  def change
    change_table :books do |t|
      t.string :author
      t.remove :publish, :dl
      t.index :title
      t.rename :isbn, :isbn_code
    end
  end
end
