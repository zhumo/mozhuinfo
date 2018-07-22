class UsersController < ApplicationController
  before_action :require_session!

  def index
    @page = Pages::Users::Index.new(view_context)
  end

  def show
    @page = Pages::Users::Show.new(view_context, user_record)
  end

  def new
    @page = Pages::Users::New.new(view_context)
  end

  def edit
    @page = Pages::Users::Edit.new(view_context, user_record)
  end

  def create
    @page = Pages::Users::New.new(view_context)

    if @page.create(user_params)
      redirect_to @page.after_create_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @page = Pages::Users::Edit.new(view_context, user_record)
    if @page.update(user_params)
      redirect_to @page.after_update_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    user_record.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
  def user_record
    @user ||= authorized_user_scope.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
end
