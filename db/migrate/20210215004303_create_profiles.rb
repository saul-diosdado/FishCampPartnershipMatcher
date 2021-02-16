class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :email
      t.string :phonenumber
      t.string :snapchat
      t.string :password
      t.string :instagram
      t.string :facebook
      t.string :twitter
      t.string :ptanimal
      t.string :pttruecolors
      t.string :ptmyersbriggs
      t.string :aboutme
      t.boolean :approvedchair
      t.boolean :gender
      t.bigint :user_id

      t.timestamps
    end
  end
end
