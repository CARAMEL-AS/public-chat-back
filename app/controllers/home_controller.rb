class HomeController < ApplicationController

    def index
        render json: { 'message': "Welcome to the Public Chat!" }
    end

end