class Contact
  include ActiveModel::Validations
  attr_accessor :user_phone
  attr_accessor :sales_phone
  validates_presence_of :user_phone
  validates_presence_of :sales_phone

  def encoded_sales_phone
    URI.encode(sales_phone)
  end
end
