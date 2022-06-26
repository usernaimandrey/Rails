# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

title1 = 'Ruby'

body1 = %(
  Ruby — динамический, рефлективный, интерпретируемый высокоуровневый язык программирования.
  Язык обладает независимой от операционной системы реализацией многопоточности,
  сильной динамической типизацией, сборщиком мусора и многими другими возможностями
)

title2 = 'Cristal'

body2 = %(
  Crystal — объектно-ориентированный язык программирования общего назначения,
спроектированный и разработанный Арье Боренцвейгом,
  Хуаном Вайнерманом и Брайаном Кардиффом.
Развивается сообществом из более 300 разработчиков.
  Обладает Ruby-подобным синтаксисом, но, в отличие от Ruby,
является компилируемым и статически типизированным языком,
  использующим вывод типов (в связи с чем явное объявление типов, как и в Ruby, не обязательно).
  Распространяется как свободное и открытое программное обеспечение под лицензией Apache версии 2.0.
)

Article.create(title: title1, body: body1)
Article.create(title: title2, body: body2)
