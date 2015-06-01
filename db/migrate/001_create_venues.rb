class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues, force: true do |t|
      t.string :name, null: false
    end
  end
end
