module SeedData

def tid class_param, name
# http://stackoverflow.com/questions/10723955/problems-while-making-a-generic-model-in-ruby-on-rails-3
	c = Class.new(ActiveRecord::Base) { self.table_name = class_param.table_name }

	c.find_by(title: name).id.to_s	
end

def load_image obj, folder_name, image_name

	File.open(File.join(Rails.root + "app/assets/images/#{folder_name}", image_name)) do |f|
		if obj.respond_to? "images"
			obj.images.clear
			obj.images << ( Image.new file: f )
			obj.save!		
		elsif obj.respond_to? "image"
			obj.image = Image.new file: f
			obj.save!
		end
	end

end


def seed_data

load_images_flag = load_shoes_flag = false;	

# Rails.env.production?

load_images_flag = true;

# load_shoes_flag = true;

# User.create(email: "admin@example.com", password: "12345678", admin: true)
# User.create(email: "user@example.com", password: "12345678")

User.delete_all

# http://stackoverflow.com/questions/4316940/create-a-devise-user-from-ruby-console
admin = User.find_or_create_by(email: "admin@example.com") { |u| u.password = "12345678"}
admin.admin = true;
admin.confirm
admin.save!

user = User.find_or_create_by(email: "user@example.com") { |u| u.password = "12345678" }
user.confirm
user.save!

user1 = User.find_or_create_by(email: "user1@example.com") { |u| u.password = "12345678" }

user1.organization = "ООО \"Ростовская обувь\""
user1.first_name = "Пётр"
user1.middle_name = "Петрович"
user1.last_name = "Петров"
user1.phone = "1234567890"
user1.city = "Ростов"
user1.address = "ул. Благодатная 4/3"
user1.contact = "Сидоров"
user1.producer = true
user1.url_name = "rostov_obuv"
user1.delivery_info = "Доставка при предоплате 100%"
user1.description = "Самая крутая организация"
user1.phone_organization = "0987654321"
user1.confirm
user1.save!

user2 = User.find_or_create_by(email: "user2@example.com") { |u| u.password = "12345678" }

user2.organization = "ИП Лелюшенко"
user2.first_name = "Сидор"
user2.middle_name = "Сидорович"
user2.last_name = "Сидоров"
user2.phone = "1234567890"
user2.city = "Ростов"
user2.address = "ул. Благодатная 4/3"
user2.contact = "Петров"
user2.producer = true
user2.url_name = "lelushenko"
user2.delivery_info = "Доставка при предоплате 100%"
user2.description = "Самая крутая организация 2"
user2.phone_organization = "0987654321"
user2.confirm

user2.save!

CategoryType.delete_all

category_type1 = CategoryType.find_or_create_by title: "Цвет"
category_type2 = CategoryType.find_or_create_by title: "Сезон"
category_type3 = CategoryType.find_or_create_by title: "Тип"

CategoryValue.delete_all

category_value1 = CategoryValue.find_or_create_by title: "Белая", category_type: category_type1
category_value2 = CategoryValue.find_or_create_by title: "Чёрная", category_type: category_type1
category_value3 = CategoryValue.find_or_create_by title: "Детская", category_type: category_type3, public: true
category_value4 = CategoryValue.find_or_create_by title: "Женская", category_type: category_type3, public: true
category_value7 = CategoryValue.find_or_create_by title: "Мужская", category_type: category_type3, public: true
category_value5 = CategoryValue.find_or_create_by title: "Лето", category_type: category_type2, public: true
category_value6 = CategoryValue.find_or_create_by title: "Зима", category_type: category_type2, public: true
category_value8 = CategoryValue.find_or_create_by title: "Осень-весна", category_type: category_type2, public: true

if load_images_flag && load_shoes_flag

	load_image category_value3, "shoes", "01.png"
	load_image category_value4, "shoes", "02.png"
	load_image category_value6, "shoes", "03.png"
	load_image category_value5, "shoes", "04.png"
	load_image category_value8, "shoes", "05.png"

end

Shoe.delete_all

shoe1 = Shoe.find_or_create_by title: "Сапоги \"Зимняя сказка\"", user: user1

shoe1.categories = { 
	tid(CategoryType, "Цвет") => tid(CategoryValue, "Чёрная"),
	tid(CategoryType, "Сезон") => tid(CategoryValue, "Зима"),
	tid(CategoryType, "Тип") => tid(CategoryValue, "Женская")
}

shoe1.save!

shoe1 = Shoe.find_or_create_by title: "Кроссовки \"Рибок\"", user: user1

shoe1.categories = { 
	tid(CategoryType, "Цвет") => tid(CategoryValue, "Белая"),
	tid(CategoryType, "Сезон") => tid(CategoryValue, "Лето"),
	tid(CategoryType, "Тип") => tid(CategoryValue, "Мужская")
}

shoe1.save!

shoe1 = Shoe.find_or_create_by title: "Сандалии \"Тезоро\"", user: user1

shoe1.categories = { 
	tid(CategoryType, "Цвет") => tid(CategoryValue, "Чёрная"),
	tid(CategoryType, "Сезон") => tid(CategoryValue, "Лето"),
	tid(CategoryType, "Тип") => tid(CategoryValue, "Мужская")
}

shoe1.save!

shoe1 = Shoe.find_or_create_by title: "Туфли \"Модница\"", user: user1, description: "Туфли женские из кожи российского производства"

shoe1.categories = { 
	tid(CategoryType, "Цвет") => tid(CategoryValue, "Белая"),
	tid(CategoryType, "Сезон") => tid(CategoryValue, "Лето"),
	tid(CategoryType, "Тип") => tid(CategoryValue, "Женская")
}

shoe1.save!

shoe1 = Shoe.find_or_create_by title: "Тапочки \"Домашние\"", user: user2

shoe1.categories = { 
	tid(CategoryType, "Цвет") => tid(CategoryValue, "Чёрная"),
	tid(CategoryType, "Сезон") => tid(CategoryValue, "Осень-весна"),
	tid(CategoryType, "Тип") => tid(CategoryValue, "Мужская")
}

shoe1.save!

ComponentType.delete_all

component_type1 = ComponentType.find_or_create_by title: "Кожа"
component_type2 = ComponentType.find_or_create_by title: "Подошва"
component_type3 = ComponentType.find_or_create_by title: "Мех"

component_type4 = ComponentType.find_or_create_by title: "Комплектующие"
component_type5 = ComponentType.find_or_create_by title: "Оборудование"
component_type6 = ComponentType.find_or_create_by title: "Клей"

component_type7 = ComponentType.find_or_create_by title: "Фурнитура"
component_type8 = ComponentType.find_or_create_by title: "Химия"
component_type9 = ComponentType.find_or_create_by title: "Инструменты"

# component_type10 = ComponentType.find_or_create_by title: "Щётки"

if load_images_flag

	load_image component_type1, "components", "кожа3.jpg"
	load_image component_type2, "components", "подошва1.jpg"
	load_image component_type3, "components", "мех2.jpg"
	load_image component_type4, "components", "комплектующие1.jpg"
	load_image component_type5, "components", "оборудование.jpg"
	load_image component_type6, "components", "клей.jpg"
	load_image component_type7, "components", "фурнитура.jpg"
	load_image component_type8, "components", "химия.jpg"
	load_image component_type9, "components", "инструменты.jpg"

end

ComponentCategoryType.delete_all

component_category_type1 = ComponentCategoryType.find_or_create_by title: "По сезону", component_type: component_type2
component_category_type2 = ComponentCategoryType.find_or_create_by title: "По типу", component_type: component_type2

ComponentCategoryValue.delete_all

component_category_value1 = ComponentCategoryValue.find_or_create_by title: "Зима", component_category_type: component_category_type1
component_category_value1 = ComponentCategoryValue.find_or_create_by title: "Лето", component_category_type: component_category_type1
component_category_value1 = ComponentCategoryValue.find_or_create_by title: "Женская", component_category_type: component_category_type2
component_category_value1 = ComponentCategoryValue.find_or_create_by title: "Мужская", component_category_type: component_category_type2

ComponentSubtype.delete_all

component_subtype1 = ComponentSubtype.find_or_create_by title: "Искусственная", component_type: component_type1
component_subtype2 = ComponentSubtype.find_or_create_by title: "Натуральная", component_type: component_type1
component_subtype3 = ComponentSubtype.find_or_create_by title: "Искусственный", component_type: component_type3
component_subtype4 = ComponentSubtype.find_or_create_by title: "Натуральный", component_type: component_type3

Component.delete_all

component1 = Component.find_or_create_by(title: "Кожа Волнистая") { |c| c.component_type_ids = component_type1.id; c.component_subtype_ids = component_subtype1.id }

component1 = Component.find_or_create_by(title: "Подошва \"0408\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Зима"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Мужская")
}

component1.description = "Подошва спортивная с повышенной износоустойчивостью. Новая модель сезона 2016 года."

if load_images_flag

	load_image component1, "components", "GL-1003 синий-серый.png" 

end

component1.save!

component1 = Component.find_or_create_by(title: "Подошва \"Рибок\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Лето"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Мужская")
}

component1.save!

component1 = Component.find_or_create_by(title: "Подошва \"Адидас\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Лето"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Мужская")
}

component1.save!

component1 = Component.find_or_create_by(title: "Подошва \"Зимняя\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Зима"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Женская")
}

component1.save!

component1 = Component.find_or_create_by(title: "Подошва \"Весенняя\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Лето"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Женская")
}

component1.save!

component1 = Component.find_or_create_by(title: "Подошва \"Летняя\"") { |c| c.component_type_ids = component_type2.id }

component1.categories = { 
	tid(ComponentCategoryType, "По сезону") => tid(ComponentCategoryValue, "Лето"),
	tid(ComponentCategoryType, "По типу") => tid(ComponentCategoryValue, "Женская")
}

component1.save!

end

end