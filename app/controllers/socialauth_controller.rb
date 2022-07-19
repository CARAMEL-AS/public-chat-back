class SocialauthController < ApplicationController

    def auth
        user = Socialauth.find_by(email: params[:email])
        if user
            render json: user.as_json(except: [:created_at, :updated_at], include: [:appwarnings, :accverify, :setting])
        else
            user = Socialauth.create!(social_auth_params)
            if user.save
                Accverify.create({user_id: user.id, code: genCode, verified: false})
                Setting.create({user_id: user.id})
                render json: user.as_json(except: [:created_at, :updated_at, :password_digest], include: [:appwarnings, :accverify, :setting]), status: :created
            else
                render json: {'error': 'Failed to create a new account'}, status: :unprocessable_entity
            end
        end
    end

    private

    def social_auth_params
        params.permit(:email, :username, :image)
    end

end