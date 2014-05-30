class SupportTicketsController < ApplicationController
  
  before_action :get_ticket, only: [:edit, :update, :destroy, :mark_resolved, :mark_unresolved]

  def index
    @support_tickets = SupportTicket.paginate(:page => params[:page]).search(params[:search])
  end

  def new
    @support_ticket = SupportTicket.new
  end

  def create
    @support_ticket = SupportTicket.new(support_ticket_params)
    if @support_ticket.save
      redirect_to support_tickets_path, notice: "Ticket created! Thank you for contacting us."
    else
      flash.now[:alert] = "Something went wrong when creating your ticket!"
      render :new
    end
  end

  def edit
  end

  def update
    if @support_ticket.update_attributes(support_ticket_params)
      redirect_to support_tickets_path, notice: "Ticket successfully updated."
    else
      flash.now[:alert] = "Something went wrong when updating your ticket!"
      render :edit
    end
  end

  def destroy
    @support_ticket.destroy
    redirect_to support_tickets_path, notice: "Ticket successfully destroyed."
  end

  def mark_resolved
    @support_ticket.status = 1
    @support_ticket.save
    redirect_to support_tickets_path
  end

  def mark_unresolved
    @support_ticket.status = 0
    @support_ticket.save
    redirect_to support_tickets_path
  end

  private


  def get_ticket
    @support_ticket = SupportTicket.find(params[:id])
  end

  def support_ticket_params
    params.require(:support_ticket).permit(:name, :email, :department, :message)
  end

end
