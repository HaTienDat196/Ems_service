# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(category_name: "Truyện ngắn")
Category.create!(category_name: "Chuyện dài")
Category.create!(category_name: "Chuyện bộ")
Category.create!(category_name: "Chuyện Chương")
Category.create!(category_name: "Chuyện phần")

99.times do |n|
  title = "Chuyện tình yêu số #{n+1}"
  category_id = rand(1..5)
  public_time = "2018-08-28 18:07:00 UTC"
  creator_name = "Tran Thi Quyen"
  creator_postion = "Ahiii"
  creator_old = "22"
  view_model = "true"
  suggestive = "true"
  content = "I love you forerver#{n+1}"
  image = File.open(Rails.root.join("app/assets/images/chothan.jpg"))
  avatar = File.open(Rails.root.join("app/assets/images/chothan.jpg"))
  Blog.create!(
    title: title,
    category_id: category_id,
    public_time: public_time,
    creator_name: creator_name,
    creator_postion: creator_postion,
    creator_old: creator_old,
    view_model: view_model,
    suggestive: suggestive,
    content: content,
    image: image,
    creator_avatar: avatar
  )
end
