class AddStatusToSupportTicket < ActiveRecord::Migration
  def change
    add_column :support_tickets, :status, :integer, default: 0
  end
end
