class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs, force: true do |t|
      t.belongs_to :venue, index: true
    end
  end
end
