Course.create! name: "Basic 1",
                description: "Description: Basic 1"

Course.create! name: "Basic 2",
                description: "Description: Basic 2"

Course.create! name: "Basic 3",
                description: "Description: Basic 3"

Word.create! content: "Apple",
              course_id: 1

Word.create! content: "Cat",
              course_id: 1

Word.create! content: "Doctor",
              course_id: 2

WordAnswer.create! content: "Quả táo",
                    correct: true,
                    word_id: 1

WordAnswer.create! content: "Quả cam",
                    correct: false,
                    word_id: 1

WordAnswer.create! content: "Quả ổi",
                    correct: false,
                    word_id: 1

WordAnswer.create! content: "Quả xoài",
                    correct: false,
                    word_id: 1

WordAnswer.create! content: "Con mèo",
                    correct: true,
                    word_id: 2

WordAnswer.create! content: "Con chó",
                    correct: false,
                    word_id: 2

WordAnswer.create! content: "Con bò",
                    correct: false,
                    word_id: 2

WordAnswer.create! content: "Con trâu",
                    correct: false,
                    word_id: 2

WordAnswer.create! content: "Bác sĩ",
                    correct: true,
                    word_id: 3

WordAnswer.create! content: "Nông dân",
                    correct: false,
                    word_id: 3

WordAnswer.create! content: "Giáo viên",
                    correct: false,
                    word_id: 3

WordAnswer.create! content: "Công an",
                    correct: false,
                    word_id: 3

20.times do |n|
  Word.create! content: "Word #{n+1}",
                course_id: rand(1..3)
  WordAnswer.create!  content: "Answer #{n+1} true",
                      correct: true,
                      word_id: n+4
  WordAnswer.create!  content: "Answer #{n+1} false",
                      correct: false,
                      word_id: n+4
end


