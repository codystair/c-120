# Onwner has many pets
  # owner can adopt pet within Shelter class
  # Pet object has a state attribute -- `adopted?`
# Pet has name and type
  # pet can be adopted within Shelter class when a owner comes
# Shelter has many registered_owners
  # Shelter object has many:
    # registered_pets
    # registered_owners

# Shelter can receive pets (method)
  # pets being stored in registered_pets
# Shetler can implement adoption process
  # send a pet to an owner
    # owner should be registered
    # pet's state should be changed
class Shelter
  attr_reader :registered_pets, :registered_owners

  def initialize
    @registered_pets, @registered_owners = [], []
  end

  def receive_pets(*pets)
    pets.flatten.each { |pet| registered_pets << pet }
  end

  def unadopted_pets
    registered_pets.select { |pet| pet.adopted? == false }
  end

  def adopt(owner, pet)
    registered_owners << owner if !registered_owners.include?(owner)
    owner.pets << pet
    pet.adopted_or_not = true
  end

  def print_adoptions
    registered_owners.each do |owner|
      puts "\n#{owner.name} has adopted #{owner.number_of_pets} pets:"
      owner.pets.each { |pet| puts pet }
    end
  end

  def print_unadopted_pets
    puts "\nThere has #{unadopted_pets.size} unadopted pets."
    unadopted_pets.each { |pet| puts pet }
  end
end

class Pet
  attr_reader :type, :name
  attr_accessor :adopted_or_not

  def initialize(type, name)
    @type = type
    @name = name
    @adopted_or_not = false
  end

  def adopted?
    adopted_or_not
  end

  def to_s
    "a #{type} called #{name}."
  end
end

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

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
shelter.print_unadopted_pets
