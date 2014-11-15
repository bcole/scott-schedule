class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.references :volunteer, index: true
      t.references :block, index: true
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
