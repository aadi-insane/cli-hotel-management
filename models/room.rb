class Room
  attr_accessor :number, :type, :price, :available

  def initialize (number, type, price, available)

    @number = number
    @type = type
    @price = price
    @available = available    
  end

  def book
    if self.available
      self.available = false    
      puts "Room No. #{self.number} is booked!"
    else
      puts "Room No #{self.number} is already booked!"    
    end
  end

  def checkout
    if !self.available
      self.available = true
      puts "Room No. #{self.number} is checked-out!"
    else
      puts "No booking available for checkout!"
    end
  end

  def show_details
    status = available ? "Available" : "Booked"
    puts "Room #{number} (#{type})  - ₹#{price} - #{status}"
    puts
  end
  
  def show_details
    status = available ? "Available" : "Booked"
    puts "Room #{number} (#{type})  - ₹#{price} - #{status}"
    puts
  end

end

# room_101 = Room.new(101, 'single', 2500, true)
# room_102 = Room.new(102, 'single', 2500, true)

# room_101.book
# room_101.checkout

# room_102.show_details