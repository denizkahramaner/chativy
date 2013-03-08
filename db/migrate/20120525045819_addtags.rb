class Addtags < ActiveRecord::Migration
    def up
        add_column :photos, :password_digest, :string
        add_column :photos, :salt, :string
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
        remove_column :photos, :password_digest
        remove_column :photos, :salt
    end
end
