class SettingController < ApplicationController

    def updateLanguage
        setting = Setting.find_by(user_id: params[:user_id])
        setting.language = params[:language]
        if setting.save
            render json: setting.to_json(except: [:created_at, :updated_at]), status: :ok
        else
            render json: {'error': 'Failed!'}, status: :unprocessable_entity
        end
    end

    def updateTheme
        setting = Setting.find_by(user_id: params[:user_id])
        setting.theme = params[:theme]
        if setting.save
            render json: setting.to_json(except: [:created_at, :updated_at]), status: :ok
        else
            render json: {'error': 'Failed!'}, status: :unprocessable_entity
        end
    end

end