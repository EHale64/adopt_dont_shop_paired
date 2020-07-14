class Favorites
  attr_reader :pets, :pet_ids

  def initialize(ids)
    if ids.nil?
      @pets = []
      @pet_ids = []
    else
      @pets = ids.map { |id| Pet.find(id)}
      @pet_ids = ids
    end
  end

  def add_pet(pet)
    #@pets << pet
    @pet_ids << pet.id
  end

  def remove_pet(pet)
    #@pets.delete(pet)
    @pet_ids.delete(pet.id)
  end
end
