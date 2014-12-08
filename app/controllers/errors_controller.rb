class ErrorsController < ApplicationController
  def not_found
    render action: 'not_found', status: 404
  end
end
