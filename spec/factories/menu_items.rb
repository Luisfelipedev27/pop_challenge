FactoryBot.define do
  factory :menu_item do
    name { "MyString" }
    description { "MyText" }
    price { "MyString" }
    menu { nil }
  end
end
