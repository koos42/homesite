# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
if (rack_env = ENV['RACK_ENV']) && rack_env == 'development'
  test_user = User.new(username: 'test', email: 'test@example.com')
  test_user.is_author = true
  test_user.password = 'test_password'
  if test_user.save
    puts "test user saved"
  else
    puts "test user not saved # going to hell ;.("
  end
end
