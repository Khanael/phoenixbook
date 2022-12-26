class FakeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts 'toto'
    sleep(3)
    puts 'done'
  end
end
