class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, force: true do |t|
      t.belongs_to :user_tab, index: true
      t.belongs_to :venue, index: true
      t.decimal :amount, precision: 8, scale: 2
      t.boolean :status
      t.timestamps null: false
    end
  end
end
