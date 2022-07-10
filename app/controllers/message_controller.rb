class MessageController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :invalid_message_params

    def is_inappropriate_message(message)
        inappropriate_words = ['fuck', 'shit', 'crap']
        (inappropriate_words - message.downcase.gsub!(/[^0-9A-Za-z]/, ' ').split(' ')).length != inappropriate_words.length
    end

    def index # get all messages - GET/messages
        messages = Message.all.to_json(except: [:updated_at])
        render json: messages, status: :ok
    end

    def create # create a new message - POST/messages
        if new_message_params
            is_it_inappropriate_message = is_inappropriate_message(params[:message])
            if is_it_inappropriate_message
                warning = Appwarning.find_by(user_id: params[:user_id])
                renderObj = {}
                if warning
                    warning.count = warning.count + 1
                    warning.save
                    renderObj = {
                        'error': 'Inappropriate message detected!',
                        'warningCount': warning.count
                    }
                else
                    warning = Appwarning.create(user_id: params[:user_id)
                    warning.count = warning.count + 1
                    warning.save
                    renderObj = {
                        'error': 'Inappropriate message detected!',
                        'warningCount': warning.count
                    }
                end
                render json: renderObj, status: :not_acceptable
            else
                firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
                newMessage = Message.create!(new_message_params)
                response = firebase.push("messages", newMessage)
                renderObj = Message.all.to_json(except: [:updated_at])
                render json: renderObj, status: :created
            end
        end
    end

    private
    
    def new_message_params
        params.permit(:user_id, :message)
    end

    def invalid_message_params(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end