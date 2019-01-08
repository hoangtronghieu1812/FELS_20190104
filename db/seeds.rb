User.create!  name: "Dương Phương Thảo",
              email: "duongthao@gmail.com",
              phone: "09888888",
              age: 22,
              job: "Sinh viên"

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

Word_answer.create! content: "Quả táo",
                    correct: true,
                    word_id: 1

Word_answer.create! content: "Quả cam",
                    correct: false,
                    word_id: 1

Word_answer.create! content: "Quả ổi",
                    correct: false,
                    word_id: 1

Word_answer.create! content: "Quả xoài",
                    correct: false,
                    word_id: 1

Word_answer.create! content: "Con mèo",
                    correct: true,
                    word_id: 2

Word_answer.create! content: "Con chó",
                    correct: false,
                    word_id: 2

Word_answer.create! content: "Con bò",
                    correct: false,
                    word_id: 2

Word_answer.create! content: "Con trâu",
                    correct: false,
                    word_id: 2

Word_answer.create! content: "Bác sĩ",
                    correct: true,
                    word_id: 3

Word_answer.create! content: "Nông dân",
                    correct: false,
                    word_id: 3

Word_answer.create! content: "Giáo viên",
                    correct: false,
                    word_id: 3

Word_answer.create! content: "Công an",
                    correct: false,
                    word_id: 3

