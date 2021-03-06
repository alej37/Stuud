class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :event

  include PgSearch::Model
  pg_search_scope :search_by_color,
    against: [ :client_id ],
    associated_against: {
      client: [ :first_name, :last_name, :color, :address, :phone, :email ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def invoice_status
    if self.event.payment_status == false && self.event.end_time <= Date.today - 7
      return 1
    elsif self.event.payment_status == false && self.event.end_time >= Date.today - 7
      return 2
    else
      return 3
    end
  end

end
