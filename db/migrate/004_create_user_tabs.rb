class CreateUserTabs < ActiveRecord::Migration
  def change
    create_table :user_tabs, force: true do |t|
      t.belongs_to :user, index: true
      t.belongs_to :tab, index: true
    end
  end
end
