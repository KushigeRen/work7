class ReservationsController < ApplicationController
    before_action :authenticate_user!

    def index

    end

    def show

    end

    def new
        @reservation = Reservation.new
    end

    def create
        @reservation = Reservation.new(reservation_param)
        if @reservation.save
            flash[:notice] = "予約が完了しました"
            redirect_to reservations_own_path
        else
            render 'rooms/show'
        end
    end

    def edit
        @reservation = Reservation.find(params[:id])
    end

    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.update(reservation_param)
            flash[:notice] = "予約内容を変更しました"
            redirect_to reservations_own_path
        else
            render "edit"
        end
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        if @reservation.destroy
            flash[:notice] = "予約をキャンセルしました"
            redirect_to reservations_own_path
        end
    end

    def comfirm
        @reservation = Reservation.find_or_initialize_by(id: params[:reservation_id])
        @reservation.assign_attributes(reservation_param)
        $room = Room.find(@reservation.room_id)
        @reservation.invalid?
        if $room.errors.present?
            if @reservation.id.nil?
                render "rooms/show"
            else
                render "edit"
            end
        end
    end

    def own
        @reservations = Reservation.reservation_room(current_user.id)
    end

    private
    def reservation_param
        params.require(:reservation).permit(:check_in_date, :check_out_date,:reservation_datetime, :number_of_guests, :user_id, :room_id)
    end
end
