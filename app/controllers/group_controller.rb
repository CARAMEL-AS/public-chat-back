class GroupController < ApplicationController

    def getMyGroups
        groups = Group.find_by(user_id: params[:user_id])
        render json: groups.to_json(except: [:created_at, :updated_at]), status: :ok
    end

    def newGroup
        group = Group.create(
            admin: params[:user_id],
            member: params[:member] 
        )
        firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
        firebase.update('', {
            "chats/#{group.id}/" => {
                id: group.id,
                member: group.member,
                messages: [params[:message]]
            }
        })
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