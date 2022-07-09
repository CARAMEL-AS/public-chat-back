class UserController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_auth_params

    def allUsers
        renderObj = User.all
        render json: renderObj, status: :ok
    end

    def index #user login - GET /user
        user = User.find_by(email: auth_params)
        if user && user.authenticate(params[:password_digest])
            render json: user.as_json(except: [:created_at, :updated_at])
        else
            renderObj = { 'error': 'Invalid password!' }
            render json: renderObj, status: :not_found
        end
    end

    def create #new user - POST /user
        user = User.create!(new_account_params).as_json(except: [:created_at, :updated_at])
        render json: user, status: :created
    end

    def update #update user info (login, status and so on) - POST /user/:id
        user = User.find(find_user_params)
        user.password_digest = params[:password_digest]
        user.online = params[:online]
        user.username = params[:username]
        user.status = params[:status]
        if user.save
            render json: user.as_json(except: [:updated_at, :updated_at]), status: :ok
        else
            renderObj = {'error': 'Failed to update user!'}
            render json: renderObj, status: :unprocessable_entity
        end
    end 

    def destroy #delete user account - DELETE /user/:id
        User.find(find_user_params).delete
        renderObj = {
            'message': 'Successfully deleted user!'
        }
        render json: renderObj, status: :ok
    end

    private

    def auth_params
        params.permit(:email)
    end

    def new_account_params
        params.permit(:email, :password_digest)
    end

    def find_user_params
        params.permit(:id)
    end

    def user_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def invalid_auth_params(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end