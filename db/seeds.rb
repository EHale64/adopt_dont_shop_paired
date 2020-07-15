# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
shelter_2 = Shelter.create(name: 'Rescue Me', address: '456 South Dr', city: 'Denver', state: 'CO', zip: '80204')
pet_1 = shelter_1.pets.create(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
pet_2 = shelter_1.pets.create(name: 'Cuddles', age: 6, sex: 'Female', image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mixed-breed-dogs-weimador-1560174538.jpg?crop=0.668xw:1.00xh;0.0459xw,0.00255xh&resize=480:*', description: 'Black Lab/Weimaraner')
pet_3 = shelter_2.pets.create(name: 'Sniffles', age: 7, sex: 'Female', image: 'https://www.feralcat.com/wp-content/uploads/2020/05/feral-kitten-003-800x532-1.jpg', description: 'Barnyard Kitty')
pet_4 = shelter_2.pets.create(name: 'Lucifer', age: 4, sex: 'Male', image: 'https://i.ytimg.com/vi/a2zbHrdgDKg/maxresdefault.jpg', description: "I'm not superstitious, but I am a little stitious.")
pet_5 = shelter_2.pets.create(name: 'Miss Tripsalot', age: 5, sex:'Female', image: 'https://animalcenter.org/wp-content/uploads/2018/12/Champion-Available-1-13-19.jpg', description: 'What she lacks in appendages, she more than makes up for in spirit!')
pet_6 = shelter_1.pets.create(name: 'Sir Fluffington', age: 4, sex: 'Male', image: 'https://www.espree.com/sites/default/files/2019-10/Samoyed.png', description: 'Samoyed')
