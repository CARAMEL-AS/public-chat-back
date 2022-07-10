class AppwarningController < ApplicationController

    def apologies
        appwarning = Appwarning.find_by(apologies_params)
        appwarning.count = 0
        appwarning.save
        renderObj = {
            'message': 'Forgiven!'
        }
        render json: renderObj, status: :ok
    end

    private

    def apologies_params
        params.permit(:user_id)
    end

end