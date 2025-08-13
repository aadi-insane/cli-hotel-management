class Booking
  attr_accessor :room, :customer, :check_in_date, :check_out_date

  def initialize(room, customer, check_in_date, check_out_date)
    @room = room
    @customer = customer
    @check_in_date = check_in_date
    @check_out_date = check_out_date
  end

  def show_details
    puts "Booking:"
    puts "Room No: #{room.number} (#{room.type})"
    puts "Customer: #{customer.name}"
    puts "Check-in: #{check_in_date}, Check-out: #{check_out_date}"
    puts
  end

end
