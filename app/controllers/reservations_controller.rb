class ReservationsController < ApplicationController
    before_action :authenticate_user!
    def index

    end

    def show

    end

    def new
        @reservation = Reservation.new
        redirect_to 'reservation/comfirm'
    end

    def create
        @reservation = Reservation.new(reservation_param)
        if @reservation.save
            # flash[:notice] = "新しい予定を登録しました"
            redirect_to reservations_own_path
        else
            render 'show'
        end
    end

    def edit

    end

    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.update(reservation_param)
            # flash[:notice] = "予定を編集しました"
            redirect_to reservations_own_path
        else
            render "edit"
        end
    end

    def destroy

    end

    def comfirm
        @reservation = Reservation.find_or_initialize_by(id: params[:id])
        # binding.pry
        @reservation.assign_attributes(reservation_param)
        # @reservation = Reservation.new(reservation_param)
    end

    def own
        @reservations = Reservation.reservation_room(current_user.id)
    end

    private
    def reservation_param
        params.require(:reservation).permit(:check_in_date, :check_out_date,:reservation_datetime, :number_of_guests, :user_id, :room_id)
        # params.permit(:check_in_date, :check_out_date, :number_of_guest, :user_id, :room_id)
    end
end
