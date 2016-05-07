# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Ride.create!([
  {title: "Carona Solidaria", origin: "Cruzeiro Novo", destiny: "UnB Gama", total_seats: 4,
  departure_time: Time.now, return_time: Time.now, is_finished: true, is_subsistence_allowance: false, is_only_departure: false,
  description: "Carona solidaria para a unb do gama", vehicle_id: 2},
  {title: "Carona muito doida", origin: "UnB gama", destiny: "Samambaia", total_seats: 3,
  departure_time: Time.now, is_finished: false, is_subsistence_allowance: true, is_only_departure: true,
  description: "Carona para samambaia", vehicle_id: 7},
  {title: "Viagem Pra Caldas", origin: "Rodoviaria de brasilia", destiny: "Caldas Novas", total_seats: 2,
  departure_time: Time.now, return_time: Time.now, is_finished: true, is_subsistence_allowance: true, is_only_departure: false,
  description: "Viagem muito doida", vehicle_id: 1},
  {title: "Carona Intercampis", origin: "UnB Darcy", destiny: "UnB Gama", total_seats: 4,
  departure_time: Time.now, return_time: Time.now, is_finished: true, is_subsistence_allowance: false, is_only_departure: false,
  description: "Carona solidaria entre campos da unb", vehicle_id: 2},
  {title: "Carona Solidaria", origin: "Cruzeiro Novo", destiny: "UnB Darcy", total_seats: 3,
  departure_time: Time.now, return_time: Time.now, is_finished: false, is_subsistence_allowance: true, is_only_departure: false,
  description: "Carona solidaria para a unb darcy", vehicle_id: 1}
])

User.create!([
  {name: "Leticia", phone: "(61) 9923-2944", token: "GIHOr845FT", gender: "Feminino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/78036afcc54_main400-300x300.jpg"},
  {name: "Maria", phone: "(61) 2345-2923", token: "GIFJ584KHO", gender: "Feminino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/1-300x300.jpg"},
  {name: "Jessica", phone: "(61) 1584-2934", token: "FDO945KH92", gender: "Feminino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/7803325b0b54_main400-300x300.jpg"},
  {name: "Victor", phone: "(55) 9923-2944", token: "IDOFJE647E", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/7804712858de_main400-300x300.jpg"},
  {name: "Sconneto", phone: "(61) 1983-2233", token: "LSOD7483JG", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/780351ec45f0_main400-300x300.jpg"},
  {name: "Daniel", phone: "(61) 9999-2999", token: "LS0293MF74", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/7803410abebe_main400-300x300.jpg"},
  {name: "Eduardo", phone: "(61) 2092-2222", token: "OOO9384MDU", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/7803734ee134_main400-300x300.jpg"},
  {name: "Miguel", phone: "(77) 1111-2222", token: "PQ0192MD84K", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/7804530f1b10_main400-300x300.jpg"},
  {name: "Vital", phone: "(61) 3339-0293", token: "PEJG748593", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/780461c18b9e_main400-300x300.jpg"},
  {name: "Dylan", phone: "(33) 1234-1234", token: "VVOSIRJF84", gender: "Masculino", photo_url: "http://pink.dornbeast.com/wp-content/uploads/2008/07/78036afcc54_main400-300x300.jpg"}
])

Vehicle.create!([
    {car_model: "Celta", color: "preto", description: "Carro preto, placa X com 2 adesivos colado na traseira"},
    {car_model: "Fiat Uno", color: "prata", description: "Carro prata, placa X"},
    {car_model: "CrossFox", color: "prata", description: "Carro prata,com 1 adesivos da nike colado no vidro"},
    {car_model: "Fusca", color: "preto", description: "Fuscão pretoooo, ele é feito de aço"},
    {car_model: "Triton", color: "preto fosco", description: "Carro preto fosco, com roda aro 20"},
    {car_model: "Veloster", color: "branco", description: "Carro branco"},
    {car_model: "Ferrari", color: "vermelho", description: ""}
])

# Criar usuários
user1 = User.find 1
user2 = User.find 2
user3 = User.find 3
user4 = User.find 4
user5 = User.find 5
user6 = User.find 6
user7 = User.find 7
user8 = User.find 8
user9 = User.find 9
user10 = User.find 10

# Setar usuario como motorista ou passageiro
user1.passager = Passager.create!()
user2.passager = Passager.create!()
user3.passager = Passager.create!()
user4.passager = Passager.create!()
user5.passager = Passager.create!()
user6.passager = Passager.create!()
user7.passager = Passager.create!()
user8.passager = Passager.create!()
user9.passager = Passager.create!()
user10.passager = Passager.create!()

user1.driver = Driver.create!()
user2.driver = Driver.create!()
user7.driver = Driver.create!()

# Criar caronas
ride1 = Ride.find 1
ride2 = Ride.find 2
ride3 = Ride.find 3
ride4 = Ride.find 4
ride5 = Ride.find 5

# Criar veiculos
vehicle1 = Vehicle.find 1
vehicle2 = Vehicle.find 2
vehicle3 = Vehicle.find 3
vehicle4 = Vehicle.find 4
vehicle5 = Vehicle.find 5
vehicle6 = Vehicle.find 6
vehicle7 = Vehicle.find 7

# Veiculos de cada usuário
user1.driver.vehicles << vehicle1 << vehicle5 << vehicle6
user2.driver.vehicles << vehicle2
user7.driver.vehicles << vehicle4 << vehicle7

# Caronas criadas pelo usuário
user1.driver.rides << ride3 << ride5
user2.driver.rides << ride4 << ride1
user7.driver.rides << ride2

# Inserindo passageiros nas caronas do usuário driver
user1.driver.rides[0].passagers << user3.passager << user4.passager
user1.driver.rides[1].passagers << user8.passager << user10.passager
user2.driver.rides[0].passagers << user3.passager << user9.passager << user8.passager
user2.driver.rides[1].passagers << user3.passager << user4.passager << user7.passager << user10.passager
user7.driver.rides[0].passagers << user1.passager

# Passageiro pesquisa carona e aperta para entrar,solicitando vaga ao driver
user3.passager.rides << ride2
