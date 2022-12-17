# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Authenticatable
  end
end
