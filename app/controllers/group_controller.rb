class GroupController < ActionController::API

    def generateCode
        chars = '0123456789QWERTYUIOPASDFGHJKLZXCVBNM'
        inviteCode = ''
        6.times do |index|
            inviteCode += rand(0...chars.length)
        end
        inviteCode
    end

    def getGroups
        if params[:uid]
            groups = []
            Group.all.times do |groupIndex|
                if Group[groupIndex].admin_id == uid || Group[groupIndex].member_ids.include?(id)
                    groups << Group[groupIndex]
                end
            end
            render json: groups;
        else
            render json: { 'error': 'Invalid-User' }
        end
    end

    def create
        if params[:uid] && params[:groupName]
            newGroup = Group.create(
                admin_id: params[:uid],
                group_name: params[:groupName],
                group_code: generateCode
            )
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end

    def blockMember
        if params[:uid] && params[:groupId] && params[:memberId]
            group = Group.find_by(id: params[:groupId])
            group.member_ids.delete(params[:memberId])
            group.banned_member_ids.push(params[:memberId])
            if group.save
                render json: { 'data': group }
            else
                render json: { 'error': "Failed to #{User.find_by(id: params[:id]).name} move to banned list! "}
            end
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end

    def unBlockMember
        if params[:uid] && params[:groupId] && params[:memberId]
            group = Group.find_by(id: params[:groupId])
            group.banned_member_ids.delete(params[:memberId])
            group.member_ids.push(params[:memberId])
            if group.save
                render json: { 'data': group }
            else
                render json: { 'error': "Failed to #{User.find_by(id: params[:id]).name} move to un-banned list! "}
            end
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end

    def delete
        if params[:uid] && params[:groupId]
            group = Group.find_by(id: params[:groupId])
            if group.admin_id == params[:uid]
                group.delete
                render json: { 'data': 'Success'}
            else
                render json: { 'error': 'Invalid User'}
            end
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end

    def join
        if params[:memberid] && params[:groupCode]
            Group.all.length.times do |index|
                
            end
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end

    def leave

    end

    def getGroupMembers
        if params[:groupId] && params[:uid]
            if User.find_by(id: params[:uid])
                members = []
                bannedMembers = []
                group = Group.find_by(id: params[:groupId])
                group.members.length.times do |memberIndex|
                    members << User.find_by(id: group.members[memberIndex])
                end
                group.banned_member_ids.length.times do |memberIndex|
                    bannedMembers << User.find_by(id: group.banned_member_ids[memberIndex])
                end
                render json: { 'members': members, 'blockedMembers': bannedMembers}
            else
                render json: { 'error': 'Invalid User!'}
            end
        else
            render json: { 'error': 'Invalid Parameters'}
        end
    end
end