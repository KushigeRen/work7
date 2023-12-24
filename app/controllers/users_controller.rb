class UsersController < ApplicationController
  before_action :authenticate_user!
    def index

    end

    def show

    end

    def new

    end

    def create

    end

    def edit

    end

    def update
        @user = User.find(params[:id])
        if @user.update(profile_param)
            # flash[:notice] = "プロフィールを編集しました"
            redirect_to root_path
        else
            render 'edit_profile'
        end
    end

    def destroy

    end

    def profile

    end

    def edit_profile
        
    end

private
  def profile_param
    params.require(:user).permit(:name, :introduction, :image)
  end
end
