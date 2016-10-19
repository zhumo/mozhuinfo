namespace :db do
  desc 'Load sample data into the DB'
  task sample_data: :environment do
    puts "Loading sample data for #{Rails.env}..."
    sample_data = File.join(Rails.root, 'db', 'sample_data.rb')
    load(sample_data) if sample_data
  end
end
