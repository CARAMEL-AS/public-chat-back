class AppwarningController < ApplicationController

    def apologies
        appwarning = Appwarning.find_by(user_id: params[:user_id])
        appwarning.count = 0
        appwarning.save
        firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
        bot = User.find_by(email: 'bot@chat-app.com')
        botMessage = Message.create(user_id: bot.id, message: "#{User.find_by(id: params[:user_id]).username} Apologised for using inappropriate language.")
        firebase.push("messages", botMessage)
        renderObj = {
            'message': 'Forgiven!'
        }
        render json: renderObj, status: :ok
    end

end