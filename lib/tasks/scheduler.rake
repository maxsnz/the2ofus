desc "This task is called by the Heroku scheduler add-on"
task :import_photos => :environment do
  puts "Importing photos..."
  ImportPhotos.call
  puts "done."
end