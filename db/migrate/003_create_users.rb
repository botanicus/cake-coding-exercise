class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: true do |t|
    end
  end
end
