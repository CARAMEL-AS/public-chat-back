class GroupController < ApplicationController

    def group_exists(newMembers, allGroups)
        exists = false
        allGroups.length.times do |groupIndex|
            if allGroups[groupIndex].members == newMembers
                exists = true
            end
        end
        exists
    end

    def getMyGroups
        groups = Group.find_by(user_id: params[:user_id])
        render json: groups.to_json(except: [:created_at, :updated_at]), status: :ok
    end

    def is_inappropriate_message(message)
        inappropriate_words = ['fuck', 'shit', 'crap']
        message.downcase.gsub!(/[^0-9A-Za-z]/, ' ') ? (inappropriate_words - message.downcase.gsub!(/[^0-9A-Za-z]/, ' ').split(' ')).length != inappropriate_words.length : inappropriate_words.include?(message.downcase)
    end

    def newGroup
        groups = Group.where(admin: params[:user_id])
        if groups && group_exists(params[:friends].sort(), groups)
            render json: {'error': 'Group already exists'}, status: :ok
        else
            group = Group.create(
                name: params[:name],
                admin: params[:user_id],
                members: params[:friends].sort()
            )
            if group.save 
                message = Message.create({user_id: group.admin, message: "Hey Folks, this is #{User.find_by(id: params[:user_id]).username}", group_id: group.id})
                firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
                firebase.update('', {
                    "chats/#{group.id}/" => {
                        id: group.id,
                        name: group.name,
                        admin: group.admin,
                        members: group.members,
                        messages: [message]
                    }
                })
                render json: group.as_json(except: [:created_at, :updated_at]), status: :created
            else 
                render json: {'error': 'Opps! Server Error'}, status: :unprocessable_entity
            end
        end
    end

    def deleteGroup
        group = Group.find_by(id: params[:group_id])
        if group.delete
            firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
            firebase.delete('', {
                "chats/#{group.id}/" => ''
            })
            render json: {'success' => true }, status: :ok
        else
            render json: {'success' => false}, status: :unprocessable_entity
        end
    end

end