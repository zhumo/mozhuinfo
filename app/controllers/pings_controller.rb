class PingsController < ApplicationController
  before_action :require_session!

  def new
    @page = Pages::Pings::New.new(view_context, user_record)
  end

  def create
    @page = Pages::Pings::New.new(view_context, user_record)

    if @page.create(ping_params)
      redirect_to @page.after_create_path, flash: { notice: "Ping Created!" }
    else
      render :new
    end
  end

  def edit
    @page = Pages::Pings::Edit.new(view_context, user_record, ping_record)
  end

  def update
    @page = Pages::Pings::Edit.new(view_context, user_record, ping_record)

    if @page.update(ping_params)
      redirect_to @page.after_update_path, flash: { notice: "Ping Updated" }
    else
      render :edit
    end
  end

  def destroy
    ping_record.destroy
    redirect_to user_record, flash: { notice: "Ping deleted"}
  end

  private

  def user_record
    @user_record ||= authorized_user_scope.find(params[:user_id])
  end

  def ping_record
    @ping_record ||= user_record.pings.find(params[:id])
  end

  def ping_params
    params.require(:ping).permit(:message, :algorithm)
  end
end
