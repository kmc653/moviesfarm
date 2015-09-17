Fabricator(:movie) do
  title { Faker::Lorem.words(5).join(" ") }
  year { Faker::Number.number(4) }
  plot { Faker::Lorem.paragraph(1) }
end