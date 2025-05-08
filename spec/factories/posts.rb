FactoryBot.define do
    factory :post do
      title { "Título do Post" }
      content { "Conteúdo do post." }
      association :user
    end
  end