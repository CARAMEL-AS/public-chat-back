class UserController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_auth_params

    def allUsers
        renderObj = User.all.to_json(except: [:created_at, :updated_at, :password_digest])
        render json: renderObj, status: :ok
    end

    def index #user login - GET /user
        user = User.find_by(email: params[:email])
        if user
            if user.password_digest == params[:password_digest]
                renderObj = user.as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings])
                render json: renderObj, status: :ok
            else
                renderObj = { 'error': 'Invalid password' }
                render json: renderObj, status: :unauthorized
            end
        else
            renderObj = { 'error': 'Account not found!' }
            render json: renderObj, status: :not_found
        end
    end

    def create #new user - POST /user
        user = User.create({email: params[:email], password_digest: params[:password_digest]}).as_json(except: [:created_at, :updated_at, :password_digest])
        firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
        response = firebase.push("users", user)
        render json: user, status: :created
    end

    def update #update user info (login, status and so on) - POST /user/:id
        user = User.find(find_user_params)
        user.password_digest = params[:password_digest]
        user.online = params[:online]
        user.username = params[:username]
        user.status = params[:status]
        if user.save
            render json: user.as_json(except: [:updated_at, :updated_at, :password_digest]), status: :ok
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
        params.permit(:email, :password_digest)
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