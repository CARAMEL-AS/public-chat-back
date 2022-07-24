class UserController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_auth_params

    def index #user login - GET /user
        user = User.find_by(email: params[:email])
        if user
            if user.password_digest == params[:password_digest] && user.accverify.verified
                renderObj = user.as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings, :accverify, :setting])
                render json: renderObj, status: :ok
            elsif !user.accverify.verified
                accver = Accverify.find_by(user_id: user.id)
                accver.code = genCode
                accver.save
                UserMailer.with(user: user, code: accver.code).verify_email.deliver_now
                render json: user.as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings, :accverify, :setting]), status: :ok
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
        user = User.create!(new_account_params)
        user.username = Faker::FunnyName.two_word_name
        if user.save
            accver = Accverify.create({user_id: user.id, code: genCode, verified: false})
            Setting.create({user_id: user.id})
            UserMailer.with(user: user, code: accver.code).verify_email.deliver_now
            render json: user.as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings, :accverify, :setting]), status: :created
        else
            render json: {"error": 'Failed!'}, status: :unauthorized
        end
    end

    def accVerify
        verify = Accverify.find_by(user_id: params[:user_id])
        if verify.code == params[:code]
            verify.verified = true
            if verify.save
                firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
                render json: User.find_by(id: params[:user_id]).as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings, :accverify, :setting]), status: :ok
            else
                render json: {'error': 'Failed to verify!'}, status: :unprocessable_entity
            end
        else
            render json: {'error': 'Invalid Code!'}, status: :unprocessable_entity
        end
    end

    def update #update user info (login, status and so on) - POST /user/:id
        user = User.find_by(id: params[:id])
        user.username = params[:username]
        if user.save
            render json: user.as_json(except: [:updated_at, :updated_at, :password_digest]), status: :ok
        else
            renderObj = {'error': 'Failed to update user!'}
            render json: renderObj, status: :unprocessable_entity
        end
    end

    def updatePic
        user = User.find_by(id: params[:id])
        user.image = params[:image]
        if user.save
            render json: user.as_json(except: [:updated_at, :updated_at, :password_digest]), status: :ok
        else
            renderObj = {'error': 'Failed to update image!'}
            render json: renderObj, status: :unprocessable_entity
        end
    end

    def destroy #delete user account - DELETE /user/:id
        user = User.find_by(id: params[:id])
        renderObj = {
            'message': 'Successfully deleted user!'
        }
        if user.delete
            render json: renderObj, status: :ok
        else
            user = Socialauth.find_by_id(params[:id])
            if user.delete
                render json: renderObj, status: :ok
            else
                render json: {'error': 'User not found'}, status: :not_found
            end
        end
    end

    def logout
        user = User.find_by(id: params[:id])
        user.online = false
        user.save
        render json: {'success': true }, status: :ok
    end

    private

    def auth_params
        params.permit(:email, :password_digest)
    end

    def new_account_params
        params.permit(:email, :password_digest, :image)
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

    def genCode
        chars = '0123456789QWERTYUIOPASDFGHJKLZXCVBNM'
        code = ''
        6.times do |i| code += chars[rand(0...chars.length)] end
        code
    end

end