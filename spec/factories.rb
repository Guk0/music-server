FactoryBot.define do  
  factory :user do
    sequence(:email) { |n| "email#{n}@music.com" }
  end

  factory :group do
    name { "new group" }
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
    name { "new artist" }
  end
  
  factory :album do
    artist
  end

  factory :track do
    artist
    album
    title { "new track" }
    artist_name { "new track artist" }
    album_name { "new track album" }
    likes_count { 157 }
  end

  factory :playlist do
    for_user
    list_type { "default" }
    title { "old title" }

    trait :for_group do
      association :owner, factory: :group
    end

    trait :for_user do
      association :owner, factory: :user
    end
  end
end