User.create!(name:  "Admin",
             email: "admin@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = "user #{n+1}"
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

words = [
  {
    word: "impetuous",
    definition: "doing something quickly without thinking of possible consequences",
    sentence: "Work done in an impetuous manner worse than undone."
  },
  {
    word: "artisan",
    definition: "someone who works with his hands producing things",
    sentence: "I enquired an artisan about his field of expertise and found out that he was well informed."
  },
  {
    word: "calumny",
    definition: "an accusation or spiteful remark",
    sentence: "I denounce those who imposed on me so many calumnies."
  },
  {
    word: "inveterate",
    definition: "something bad that happens repeatedly and can't be stopped",
    sentence: "I'm tired of your inveterate attacks."
  },
  {
    word: "affidavit",
    definition: "a document that validates something",
    sentence: "That's a kind of unconcealed lie that he put in his affidavit."
  },
  {
    word: "zeal",
    definition: "great energy and passion",
    sentence: "Mistakes that we reenact with admirable zeal."
  },
  {
    word: "stout",
    definition: "strong and robust",
    sentence: "Your argument is seemingly stout, but flimsy on close examination."
  },
  {
    word: "admonish",
    definition: "to encourage or approve of",
    sentence: "I don't condone nor admonish such behavior."
  },
  {
    word: "facetious",
    definition: "done in jest when it is inconsiderate",
    sentence: "Her facetious remarks are completely out of line."
  }
]

words.each do |word|
  Word.create!(word: word[:word],
               definition: word[:definition],
               sentence: word[:sentence])
end

user  = User.first
Word.all[0..5].each { |word| user.add(word) }
