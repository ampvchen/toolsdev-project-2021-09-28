HiringProject::Application.load_tasks

class UpdateWeatherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rake::Task['weather:update'].invoke
  end
end
