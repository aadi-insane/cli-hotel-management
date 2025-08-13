class Customer
  attr_accessor :name, :phone, :email

  def initialize(name, phone, email)
    @name = name
    @phone = phone 
    @email = email
  end

  def show_details
    puts "Name    : #{self.name}"
    puts "Phone   : #{self.phone}"
    puts "E-mail  : #{self.email}"
  end
end
