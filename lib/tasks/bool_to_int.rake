task :bool_to_int => :environment do
  User.where("admin = 't'").update_all(admin: 1)
  User.where("admin = 'f'").update_all(admin: 0)
  User.where("activated = 't'").update_all(activated: 1)
  User.where("activated = 'f'").update_all(activated: 0)
end
