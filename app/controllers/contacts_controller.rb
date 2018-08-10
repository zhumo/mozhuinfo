class ContactsController < ApplicationController
  before_action :require_session!

  def index
    @page = Pages::Contacts::Index.new(view_context)
  end

  def show
    @page = Pages::Contacts::Show.new(view_context, contact_record)
  end

  def new
    @page = Pages::Contacts::New.new(view_context)
  end

  def edit
    @page = Pages::Contacts::Edit.new(view_context, contact_record)
  end

  def create
    @page = Pages::Contacts::New.new(view_context)

    if @page.create(contact_params)
      redirect_to @page.after_create_path, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def update
    @page = Pages::Contacts::Edit.new(view_context, contact_record)
    if @page.update(contact_params)
      redirect_to @page.after_update_path, notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    contact_record.destroy
    redirect_to contacts_url, notice: 'Contact was successfully destroyed.'
  end

  private
  def contact_record
    @contact ||= authorized_contact_scope.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :phone_number)
  end
end
