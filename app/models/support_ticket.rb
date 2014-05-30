class SupportTicket < ActiveRecord::Base

  validates :name, :email, :department, :message, presence: true

def self.search(search)
  if search
    where(['name LIKE ? OR email LIKE ? OR message LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"]).order("status ASC")
  else
    all.order("status ASC")
  end
end


end
