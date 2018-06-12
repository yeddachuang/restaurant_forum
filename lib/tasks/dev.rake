namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data (#{Restaurant.first.id} ~ #{Restaurant.last.id})"
  end

  task fake_user: :environment do
    User.destroy_all

    20.times do |i|
      User.create!(email: FFaker::Internet.email,
         password: "12345678",
         role: nil)
    end
    User.create(email: "yedda@yedda.com", password: "yeddaa", role: "admin")
    puts "have created fake users"
    puts "now you have #{User.count} users data (#{User.first.id} ~ #{User.last.id})"
  end

    task fake_comment: :environment do
      Comment.destroy_all

      Restaurant.count.times do |i|
        3.times do |j|
          Comment.create!(content: FFaker::Lorem.paragraphs,
            restaurant_id: Restaurant.find_by(id: (Restaurant.first.id + i)).id,
            user_id: User.find_by(id: (User.first.id + rand(User.count))).id
          )
        end
      end
      puts "have created fake users"
      puts "now you have #{Comment.count} comments data (#{Comment.first.id} ~ #{Comment.last.id})"
    end
end
