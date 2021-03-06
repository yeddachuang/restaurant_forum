namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        favorites_count: 0
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data (#{Restaurant.first.id} ~ #{Restaurant.last.id})"
  end

  task fake_user: :environment do
    User.destroy_all
    User.create(name: "Yedda", intro: "I love Taiwan!", email: "yedda@yedda.com", password: "yeddaa", role: "admin")

    50.times do |i|
      User.create!(email: FFaker::Internet.email,
        name: FFaker::Name.first_name,
        intro: FFaker::Lorem.paragraphs,
        password: 123456,
        role: nil)
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data (#{User.first.id} ~ #{User.last.id})"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
      3.times do |i|
        Comment.create!(content: FFaker::Lorem.paragraphs,
          restaurant_id: restaurant.id,
          user_id: User.all.sample.id
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data (#{Comment.first.id} ~ #{Comment.last.id})"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all

    Restaurant.all.each do |restaurant|
      rand(30).times do |i|
        user = User.all.sample
        if !restaurant.is_favorited?(user)
          Favorite.create!(restaurant_id: restaurant.id,
            user_id: user.id
          )
        end
      end
    end
    puts "have created fake favorites"
    puts "now you have #{Favorite.count} comments data (#{Favorite.first.id} ~ #{Favorite.last.id})"
  end

  task fake_like: :environment do
    Like.destroy_all

    Restaurant.all.each do |restaurant|
      rand(50).times do |i|
        user = User.all.sample
        if !restaurant.is_favorited?(user)
          Like.create!(restaurant_id: restaurant.id,
            user_id: user.id
          )
        end
      end
    end
    puts "have created fake likes"
    puts "now you have #{Like.count} comments data (#{Like.first.id} ~ #{Like.last.id})"
  end

  task fake_follow: :environment do
    Followship.destroy_all

    User.all.each do |user|
      rand(User.all.count).times do |i|
        following = User.all.sample
        if !user.following?(following)
          user.followships.create!(following_id: following.id)
        end
      end
    end
    puts "have created fake followings"
    puts "now you have #{Followship.count} following relationship (#{Followship.first.id} ~ #{Followship.last.id})"
  end

  task fake_friend: :environment do
    Friendship.destroy_all

    User.all.each do |user|
      rand(User.all.count).times do |i|
        friend = User.all.sample
        if !user.friend?(friend)
          #user.friends.create!(friend_id: friend.id, status: 1)
          Friendship.create!(user_id: user.id, friend_id: friend.id, status: 1)
          puts "new friendship"
        end
      end
    end
    puts "have created fake friendships"
    puts "now you have #{Friendship.count} friendships (#{Friendship.first.id} ~ #{Friendship.last.id})"
  end

  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    puts "fake_restaurant processing..."
    Rake::Task['dev:fake_restaurant'].execute
    puts "fake_user processing..."
    Rake::Task['dev:fake_user'].execute
    puts "fake_comment processing..."
    Rake::Task['dev:fake_comment'].execute
    puts "fake_favorite processing..."
    Rake::Task['dev:fake_favorite'].execute
    puts "fake_like processing..."
    Rake::Task['dev:fake_like'].execute
    puts "fake_follow processing..."
    Rake::Task['dev:fake_follow'].execute
    #看還有甚麼fake都能放進來
  end

end
