class Hotel
  attr_accessor :name, :rooms, :bookings

  def initialize(name)
    @name = name    
    @rooms = []
    @bookings = []
  end

  def add_room(room)
    rooms.push(room)    
    puts "Room #{room.number} (#{room.type}) is added to #{name}, successfully!"
  end

  def list_all_rooms
    available_rooms = rooms.select {|room| true}
    if available_rooms.empty?
      puts "No rooms available at this time!"
    else
      available_rooms.each { |room| room.show_details }
    end
  end

  def list_available_rooms
    available_rooms = rooms.select {|room| room.available}
    if available_rooms.empty?
      puts "No rooms available at this time!"
    else
      available_rooms.each { |room| room.show_details }
    end
  end
  
  def list_bookings
    available_bookings = bookings.select {|b| true}
    if available_bookings.empty?
      puts "No rooms available at this time!"
    else
      available_bookings.each { |room| room.show_details }
    end
  end

  def book_room(customer, room_number, check_in, check_out)
    room = rooms.find {|r| r.number == room_number && r.available}
    if room
      room.book
      booking = Booking.new(room, customer, check_in, check_out)
      bookings.push(booking)
      puts "Booking confirmed for #{customer.name} in Room #{room_number} frome #{check_in} to #{check_out}."
    else
      puts "Room #{room_number} is not available."
    end
  end

  def cancel_booking(room_number)
    booking = bookings.find { |b| b.room.number == room_number }
    if booking
      booking.room.checkout
      bookings.delete(booking)
      puts "Booking for Room #{room_number} canceled."
    else
      puts "No booking found for Room #{room_number}."
    end
  end
end
