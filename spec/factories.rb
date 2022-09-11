FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@music.com" }
  end

  factory :artist do
    name { "test" }
  end
  
  factory :album do
    artist { Artist.first }
  end

  factory :track do
    artist { Artist.first }
    album { Album.first }
    title { "test" }
    artist_name { "test" }
    album_name { "test" }
    likes_count { 157 }
  end

  factory :my_playlist, class: "Playlist" do
    owner_type { "User" }
    owner_id { User.first.id }
    title { "old title" }
    list_type { "default" }

    trait :invalid do
       owner_id { nil }
    end
  end

  factory :my_album, class: "Playlist" do
    owner { User.first }
    title { "test" }
    list_type { 1 }
  end

  # factory :album2, class: "Album" do
  # end
end