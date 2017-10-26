namespace :dynamizer do
  desc "Updates the docs"
  task :update_all do
    require_relative "../dynamizer/document_updater"
    Dynamizer::DocumentUpdater.new.update_all!
  end
end

