class RoomsController < ApplicationController
    before_action :authenticate_user!, except: [:show,:search]
    def index

    end

    def show
        @room = Room.find(params[:id])
    end

    def new
        @room = Room.new
    end

    def create
        @room = Room.new(room_param)
        if @room.save
            # flash[:notice] = "新しい予定を登録しました"
            redirect_to room_path(@room.id)
        else
            render 'new'
        end
    end

    def edit
        @room = Room.find(params[:id])
    end

    def update
        @room = Room.find(params[:id])
        if @room.update(room_param)
        # flash[:notice] = "予定を編集しました"
        redirect_to room_path
        else
        render "edit"
        end
    end

    def destroy

    end

    def search
        if params[:room_address].blank? && params[:room_name].blank?
            @rooms = Room.all
        elsif params[:room_address].blank?
            @rooms = Room.find_by_name(params[:room_name])
        elsif params[:room_name].blank?
            @rooms = Room.find_by_address(params[:room_address])
        else
            @rooms = Room.find_by_name_address(params[:room_name],params[:room_address])
        end
    end

    def own
        @rooms = Room.registered_room(current_user.id)
    end


private
    def room_param
        params.require(:room).permit(:name, :detail, :fee, :address, :user_id, :image)
    end
end
