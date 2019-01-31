User.create! email: "user1@example.com", password:"111111", name: "Hieu Hoang Trong", image: File.open("app/assets/images/Hieu.jpg")
User.create! email: "user2@example.com", password:"111111", name: "Phan Quynh Nhu",
  image: File.open("app/assets/images/Rose.jpg")
User.create! email: "user3@example.com", password:"111111", name: "Ngo Trang Ngan",
  image: File.open("app/assets/images/jennie.png")

6.times do |n|
  Course.create!  name: "Basic #{n+1}",
                  description: "Description: Basic #{n+1}",
                  image: "course_#{n+1}.jpg"
end

Word.create!  content: "Apple",
              course_id: 1

Word.create!  content: "Cat",
              course_id: 1

Word.create!  content: "Doctor",
              course_id: 2

WordAnswer.create!  content: "Quả táo",
                    correct: true,
                    word_id: 1

WordAnswer.create!  content: "Quả cam",
                    correct: false,
                    word_id: 1

WordAnswer.create!  content: "Quả ổi",
                    correct: false,
                    word_id: 1

WordAnswer.create!  content: "Quả xoài",
                    correct: false,
                    word_id: 1

WordAnswer.create!  content: "Con mèo",
                    correct: true,
                    word_id: 2

WordAnswer.create!  content: "Con chó",
                    correct: false,
                    word_id: 2

WordAnswer.create!  content: "Con bò",
                    correct: false,
                    word_id: 2

WordAnswer.create!  content: "Con trâu",
                    correct: false,
                    word_id: 2

WordAnswer.create!  content: "Bác sĩ",
                    correct: true,
                    word_id: 3

WordAnswer.create!  content: "Nông dân",
                    correct: false,
                    word_id: 3

WordAnswer.create!  content: "Giáo viên",
                    correct: false,
                    word_id: 3

WordAnswer.create!  content: "Công an",
                    correct: false,
                    word_id: 3

30.times do |n|
  Word.create!  content: "Word #{n+1}",
                course_id: rand(2..6)
  WordAnswer.create!  content: "Answer #{n+1} true",
                      correct: true,
                      word_id: n+4
  WordAnswer.create!  content: "1 Answer #{n+1} false",
                      correct: false,
                      word_id: n+4
  WordAnswer.create!  content: "2 Answer #{n+1} false",
                      correct: false,
                      word_id: n+4
  WordAnswer.create!  content: "3 Answer #{n+1} false",
                      correct: false,
                      word_id: n+4
end

Lesson.create!  user_id: 1,
                course_id: 1,
                results: 20

Lesson.create!  user_id: 1,
                course_id: 2,
                results: 30

Lesson.create!  user_id: 2,
                course_id: 2,
                results: 30

Lesson.create!  user_id: 3,
                course_id: 3,
                results: 30

10.times do |n|
  Lesson.create!  user_id: rand(1..3),
                  course_id: rand(1..6),
                  results: rand(20..50)
end

Lesson.create!  user_id: 2,
                course_id: 2,
                results: 30

Lesson.create!  user_id: 3,
                course_id: 3,
                results: 30

1.upto 10 do |n|
  LessonAnswer.create!  word_answer_id: n*4-1,
                        word_id: n,
                        lesson_id: 1
end

7.upto 15 do |n|
  LessonAnswer.create!  word_answer_id: n*4-1,
                        word_id: n,
                        lesson_id: 2
end

LessonAnswer.create! word_id: 17,
                     word_answer_id: 67,
                     lesson_id: 2

Lesson.all.each do |l|
  l.create_activity :create , owner: User.find(l.user_id), recipient: Course.find(l.course_id)
end

a = Relationship.create! followed_id: 1, follower_id: 2
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy

a = Relationship.create! followed_id: 1, follower_id: 3
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy

a = Relationship.create! followed_id: 2, follower_id: 3
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy

a = Relationship.create! followed_id: 2, follower_id: 1
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy

a = Relationship.create! followed_id: 3, follower_id: 1
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy

a = Relationship.create! followed_id: 3, follower_id: 2
a.create_activity :create, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.create_activity :destroy, owner: User.find(a.follower_id), recipient: User.find(a.followed_id)
a.destroy
