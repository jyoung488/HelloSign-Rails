class CreateSigns < ActiveRecord::Migration[5.0]
  def change
    create_table :signs do |t|
      t.text :signature_request_id
      t.text :status

      t.timestamps
    end
  end
end
