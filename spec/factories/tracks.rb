FactoryBot.define do
  factory :track do
    title { "MyString" }
    artist { nil }
    album { nil }
    artist_name { "MyString" }
    album_name { "MyString" }
    likes_count { 1 }
  end
end
