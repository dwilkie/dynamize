namespace :dynamizer do
  desc "Dynamizes your templates"
  task :dynamize do
    require_relative "../dynamizer/runner"
    Dynamizer::Runner.new.dynamize!
  end
end

