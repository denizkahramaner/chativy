class Addlogin < ActiveRecord::Migration
    def up
        #for users
        add_column :users, :login, :string
        User.reset_column_information
        all_users = User.find(:all)
        all_users.each do |current_user|
        	current_user.login = current_user.last_name.downcase
        	current_user.save(:validate => false)
        end
    end
    
    def down
        remove_column :users, :login
    end
end
