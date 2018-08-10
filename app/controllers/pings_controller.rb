class PingsController < ApplicationController
  before_action :require_session!

  def new
    @page = Pages::Pings::New.new(view_context, contact_record)
  end

  def create
    @page = Pages::Pings::New.new(view_context, contact_record)

    if @page.create(ping_params)
      redirect_to @page.after_create_path, flash: { notice: "Ping Created!" }
    else
      render :new
    end
  end

  def edit
    @page = Pages::Pings::Edit.new(view_context, contact_record, ping_record)
  end

  def update
    @page = Pages::Pings::Edit.new(view_context, contact_record, ping_record)

    if @page.update(ping_params)
      redirect_to @page.after_update_path, flash: { notice: "Ping Updated" }
    else
      render :edit
    end
  end

  def destroy
    ping_record.destroy
    redirect_to contact_record, flash: { notice: "Ping deleted"}
  end

  private

  def contact_record
    @contact_record ||= authorized_contact_scope.find(params[:contact_id])
  end

  def ping_record
    @ping_record ||= contact_record.pings.find(params[:id])
  end

  def ping_params
    params.require(:ping).permit(:message, :algorithm)
  end
end
