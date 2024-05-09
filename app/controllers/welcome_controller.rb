class WelcomeController < ApplicationController
  def welcome
    render json: { message: "This is Coxinha Toda Toda API" }
  end
end
