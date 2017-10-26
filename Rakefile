require_relative "lib/dynamizer"
Dir.glob('lib/tasks/*.rake').each { |r| load r}

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
end

