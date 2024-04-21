# frozen_string_literal: true

require 'sidekiq'

class BaseJob
  include Sidekiq::Job
end
