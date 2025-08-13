require 'json'
require_relative 'models/room'
require_relative 'models/customer'
require_relative 'models/booking'
require_relative 'models/hotel'

def load_rooms(file_path)
  data = JSON.parse(File.read(file_path))
  data.map do |room_data|
    Room.new(
      room_data["number"],
      room_data["type"],
      room_data["price"],
      room_data["available"]
    )
  end
end

# def load_rooms(file_path)
#   File.open(file_path, "r") do |file|
#     file.read
#   end
# end


# rooms_file = "data/rooms.json"

# puts load_rooms(rooms_file)

def load_bookings(file_path, rooms)
  data = JSON.parse(File.read(file_path))
  data.map do |b|
    room = rooms.find { |r| r.number == b["room_number"] }
    customer = Customer.new(b["customer_name"], b["customer_phone"], b["customer_email"])
    Booking.new(room, customer, b["check_in_date"], b["check_out_date"])
  end
end

def save_rooms(file_path, rooms)
  data = rooms.map do |room|
    {
      number: room.number,
      type: room.type,
      price: room.price,
      available: room.available
    }
  end
  File.write(file_path, JSON.pretty_generate(data))
end

def save_bookings(file_path, bookings)
  data = bookings.map do |b|
    {
      room_number: b.room.number,
      customer_name: b.customer.name,
      customer_phone: b.customer.phone,
      customer_email: b.customer.email,
      check_in_date: b.check_in_date,
      check_out_date: b.check_out_date
    }
  end
  File.write(file_path, JSON.pretty_generate(data))
end


rooms_file = "data/rooms.json"
bookings_file = "data/bookings.json"

rooms = load_rooms(rooms_file)
bookings = load_bookings(bookings_file, rooms)

hotel_1 = Hotel.new("Hotel Ruby Palace")
hotel_1.rooms = rooms
hotel_1.bookings = bookings

puts "===================== Welcome to Hotel Room Booking system ===================="

# hotel_1 = Hotel.new("Hotel Ruby Palace")
puts "                               #{hotel_1.name.upcase}"

while true
  puts "To see all rooms details, press '1'"
  puts "To see available rooms, press '2'"
  puts "To book a room, press '3'"
  puts "To cancel a room booking, press '4'"
  puts "To see bookings list, press '5'"
  puts "To exit, press 'any key'"


  choice = gets.chomp.to_i

  puts
  
  case choice
  when 1 then hotel_1.list_all_rooms
  when 2 then hotel_1.list_available_rooms
  when 3
    puts "Enter customer name:"
    name = gets.chomp
    puts "Enter phone:"
    phone = gets.chomp
    puts "Enter email:"
    email = gets.chomp
    customer = Customer.new(name, phone, email)

    puts "Enter room number to book:"
    room_no = gets.chomp.to_i
    until (101..110).include?(room_no) || (201..205).include?(room_no) || (301..305).include?(room_no)
      puts "Invalid Room No. Try again!"
      room_no = gets.chomp.to_i
    end

    puts "Enter check-in date (YYYY-MM-DD):"
    check_in = gets.chomp
    puts "Enter check-out date (YYYY-MM-DD):"
    check_out = gets.chomp

    hotel_1.book_room(customer, room_no, check_in, check_out)
    save_rooms(rooms_file, hotel_1.rooms)
    save_bookings(bookings_file, hotel_1.bookings)

  when 4
    puts "Enter Room No. to cancel its booking :"
    room_number = gets.chomp.to_i
    if room_number.is_a?(Integer) && ((101..110).include?(room_number) || (201..205).include?(room_number) || (301..305).include?(room_number))
      hotel_1.cancel_booking(room_number)
      save_rooms(rooms_file, hotel_1.rooms)
      save_bookings(bookings_file, hotel_1.bookings)
    else
      puts "Invalid input or incorrect Room No."
      puts
    end

  when 5
    hotel_1.list_bookings

  else
    puts "Bye-Bye, Thankyou for using 'Hotel Room Booking system'!"
    return
  end
end

