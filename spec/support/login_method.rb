def user_login()
  user = User.create!(name: 'João Almeida', email: 'joao@gmail.com', 
                      password: '12345678')
  login_as(user, scope: :user)
end