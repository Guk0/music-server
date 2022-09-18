FactoryBot.define do  
  factory :user do
    sequence(:email) { |n| "email#{n}@music.com" }
  end

  factory :group do
    name { "name" }
    association :owner, factory: :user

    trait :invalid do
      name { nil }
    end

    factory :group_with_users do
      transient do
        users_count { 5 }
      end

      after(:create) do |group, evaluator|
        create_list(:user, evaluator.users_count, groups: [group])
        group.reload
      end
    end
  end

  factory :artist do
    name { "artist" }

    trait :invalid do
      name { nil }
    end
  end
  
  factory :album do
    title { "album" }
    artist { association(:artist) }

    trait :invalid do
      name { nil }
    end
  end

  factory :track do
    artist
    album
    title { "track" }
    artist_name { "track artist" }
    album_name { "track album" }
    likes_count { 157 }

    trait :invalid do
      title { nil }
    end

    before(:create) do |track, evaluator|      
      track._commit_callbacks.clear
    end
  end

  factory :playlist do
    for_user
    list_type { "my_album" }
    title { "title" }

    trait :for_group do
      association :owner, factory: :group
    end

    trait :for_user do
      association :owner, factory: :user
    end
  end

  factory :playlist_track do
    track
    playlist
    user
  end
end