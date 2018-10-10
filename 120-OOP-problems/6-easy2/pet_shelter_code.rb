class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  attr_reader :owners, :registered_pets

  def initialize
    @owners = []
    @registered_pets = []
  end

  def receive_pet(pet)
    registered_pets << pet
  end

  def adopt(owner, pet)
    receive_pet(pet)
    pet.adopted = true
    owner.pets << pet
    owners << owner if !@owners.include?(owner)
  end

  def unadopted_pets
    registered_pets.select { |pet| pet.adopted == false }
  end

  def print_unadopted_pets
    if !unadopted_pets.empty?
      puts "The Animal Shelter has the following unadopted pets:"
      unadopted_pets.each { |unadopted_pet| unadopted_pet.print_info }
    end
  end

  def print_adoptions
    owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each { |pet| pet.print_info }
    end
    print_unadopted_pets
  end
end

class Pet
  attr_reader :type, :name
  attr_accessor :adopted

  def initialize(type, name)
    @type = type
    @name = name
    @adopted = false
  end

  def print_info
    puts "a #{type} named #{name}"
  end
end

# adopted
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
#unadopted
asta       = Pet.new('cat', 'Asta')
laddie     = Pet.new('cat', 'Laddie')
fluffy     = Pet.new('cat', 'Fluffy')
kat        = Pet.new('cat', 'Kat')
ben        = Pet.new('cat', 'Ben')
chatterbox = Pet.new('cat', 'Chatterbox')
bluebell   = Pet.new('cat', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
pets = [butterscotch, pudding, darwin, kennedy, sweetie, molly, chester]
pets += [asta, laddie, fluffy, kat, ben, chatterbox, bluebell]

shelter.receive_pets(pets)

puts "There has #{shelter.unadopted_pets.size} unadopted pets."

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "There has #{shelter.unadopted_pets.size} unadopted pets."
