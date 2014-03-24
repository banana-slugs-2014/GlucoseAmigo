

10.times do |i|

  Account.create(username: Faker::Name.name,
                 password: "password",
                 password_confirmation: "password",
                 email: Faker::Internet.email)

  Doctor.create(name: Faker::Name.name,
                fax: "+1-800-555-555#{i}",
                comments: Faker::Lorem.sentence,
                email: Faker::Internet.email)


  Account.last.diabetics.create(name: Faker::Name.name,
                                email: Faker::Internet.email,
                                birthday: Date.today - rand(2000))


  Diabetic.last.preference = Preference.create(reminders: true,
                                   frequency: (i + 1))
  3.times do
    7.times do |j|
      Diabetic.last.records.create(weight: "20#{i}",
                                   glucose: rand(75..100).to_s,
                                   taken_at: Date.today - (j) )
    end
  end
end