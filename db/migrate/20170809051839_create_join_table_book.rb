class CreateJoinTableBook < ActiveRecord::Migration[5.1]
  def change
    create_join_table :author, :books
  end
end
