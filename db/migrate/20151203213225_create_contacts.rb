class CreateContacts < ActiveRecord::Migration
	def change
		create_table :contacts do |t|
			t.references :user, index: true, foreign_key: true
			t.references :state, index: true, foreign_key: true
			t.string :name
			t.string :email
			t.string :phone1
			t.string :phone2
			t.date :birthdate
			t.string :address
			t.attachment :avatar
			t.timestamps null: false
		end
	end
end
