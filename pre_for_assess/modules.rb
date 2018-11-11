class EmployeeManagementSystem
  attr_reader :employees

  def initialize
    @employees = []
  end
end

class Employee
  attr_reader :name, :serial_number, :type, :vacation_days, :desk

  VACATION_FOR_EXECUTIVE = 20
  VACATION_FOR_MANAGER = 14
  VACATION_FOR_REGULAR = 10
  DESK_FOR_EXECUTIVE = 'corner office'
  DESK_FOR_MANAGER = 'private office'
  DESK_FOR_REGULAR = 'cubicle farm'

  def initialize(name, serial_number)
    @name = name.capitalize
    @serial_number = serial_number
    allocate_type
    allocate_vacation_days
    allocate_desk
  end

  def allocate_type
    @type =
      if self.class.name.downcase.start_with?('p')
        'part time'
      else
        self.class.name
      end
  end

  def allocate_vacation_days
    @vacation_days =
      case type
      when 'Executive'
        VACATION_FOR_EXECUTIVE
      when 'Manager'
        VACATION_FOR_MANAGER
      when 'Regular'
        VACATION_FOR_REGULAR
      else
        'None'
      end
  end

  def allocate_desk
    @desk =
      case type
      when 'Executive'
        DESK_FOR_EXECUTIVE
      when 'Manager'
        DESK_FOR_MANAGER
      when 'Regular'
        DESK_FOR_REGULAR
      else 'None'
      end
  end

  def to_s
    <<-M

      Name: #{name}
      Type: #{type}
      Serial number: #{serial_number}
      Vacation days: #{vacation_days}
      Desk: #{desk}

    M
  end
end

class PartTimeEmployee < Employee
end

class FullTimeEmployee < Employee
  def take_vacation
  end
end

module Delegatable
  def delegate
  end
end

class Executive < FullTimeEmployee
  include Delegatable
end

class Manager < FullTimeEmployee
  include Delegatable
end

class Regular < FullTimeEmployee
end

puts Executive.new('Bob', 12345)
puts Manager.new('Sally', 12345)
puts Regular.new('Lee', 12345)
puts PartTimeEmployee.new('Wu', 12345)
