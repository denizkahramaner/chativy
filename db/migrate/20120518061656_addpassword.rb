class Addpassword < ActiveRecord::Migration
    def up
        add_column :users, :password_digest, :string
        add_column :users, :salt, :string
        User.reset_column_information
        all_users = User.find(:all)
        all_users.each do |current_user|
        	salt = Random.rand.to_s
        	current_user.password_digest = Digest::SHA1.hexdigest(current_user.last_name + salt.to_s)
        	current_user.salt = salt
        	#current_user.update_attribute(:salt => salt)
        	current_user.save(:validate => false)
        end

    end
    
    def down
        remove_column :users, :password_digest
        remove_column :users, :salt
    end
end
