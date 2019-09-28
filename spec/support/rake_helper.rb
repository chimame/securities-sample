require 'rake'

RSpec.configure do |config|
  config.before(:all, type: :rake) do
    Rails.application.load_tasks # Load all the tasks just as Rails does (`load 'Rakefile'` is another simple way)
  end

  config.before(:each, type: :rake) do
    Rake.application.tasks.each(&:reenable) # Remove persistency between examples
  end
end
