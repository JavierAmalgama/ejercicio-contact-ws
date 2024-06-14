Faker::Config.locale = 'es'

def create_countries
	argentina = Country.create name: 'Argentina'
	uruguay = Country.create name: 'Uruguay'
	brasil = Country.create name: 'Brasil'

	[ 'Buenos Aires', 'Catamarca', 'Chaco', 'Chubut', 'Ciudad de Buenos Aires', 'Córdoba', 'Corrientes', 'Entre Ríos', 'Formosa', 'Jujuy', 'La Pampa', 'La Rioja', 'Mendoza', 'Misiones', 'Neuquén', 'Río Negro', 'Salta', 'San Juan', 'San Luis', 'Santa Cruz', 'Santa Fernando', 'Santiago del Estero', 'Tierra del Fuego', 'Tucumán' ].each do |state|
		State.create country: argentina, name: state
	end

	[ 'Acre', 'Alagoas', 'Amapá', 'Amazonas', 'Bahia', 'Ceará', 'Distrito Federal', 'Espírito Santo', 'Goiás', 'Maranhão', 'Mato Grosso', 'Mato Grosso do Sul', 'Minas Gerais', 'Pará', 'Paraíba', 'Paraná', 'Pernambuco', 'Piaui', 'Rio de Janeiro', 'Rio Grande do Norte', 'Rio Grande do Sul', 'Rondônia', 'Roraima', 'Santa Catarina', 'São Paulo', 'Sergipe', 'Tocantins' ].each do |state|
		State.create country: brasil, name: state
	end

	[ 'Artigas', 'Canelones', 'Cerro Largo', 'Colonia', 'Durazno', 'Flores', 'Florida', 'Lavalleja', 'Maldonado', 'Montevideo', 'Paysandú', 'Río Negro', 'Rivera', 'Rocha', 'Salto', 'San José', 'Soriano', 'Tacuarembó', 'Treinta y Tres' ].each do |state|
		State.create country: uruguay, name: state
	end
end

def create_users
	password = 'S0mePassw0rd!'
	10.times do |number|
		User.create email: "user#{number + 1}@domain.com", password: password, password_confirmation: password
	end
end

def create_contacts
	state_count = State.count
	100.times do
		Contact.create(
			user_id: 1,
			state_id: 1 + Random.rand( state_count ),
			name: Faker::Name.name,
			email: Faker::Internet.email,
			address: Faker::Address.street_address,
			phone1: Faker::PhoneNumber.phone_number,
			phone2: Faker::PhoneNumber.cell_phone,
			birthdate: Faker::Time.between( 60.years.ago, 18.year.ago, :all )
		)
	end
end

create_countries
create_users
create_contacts
