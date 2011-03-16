class AddGodUserToUsers < ActiveRecord::Migration
  def self.up
    User.create( :username => 'god', 
                     :email => 'ko.os42@gmail.com', 
                     :password => 'godgod', 
                     :password_confirmation => 'godgod'
                   )
    god = User.where('username = ?', 'god').first
    god.update_attribute('is_author', true)
    puts "there is a god"
  end

  def self.down
    god = User.where('username = ?', 'god').first
    puts god.is_author
    god.delete if god #if there is a god, kill it.
    puts "there is no god"
  end
end
