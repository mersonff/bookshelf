# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Authenticatable

    include SimpleErrorRenderable
    self.simple_error_partial = "shared/simple_error"
  end
end
