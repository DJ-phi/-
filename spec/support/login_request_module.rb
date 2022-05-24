module SignInRequestModule
  def login
    login_params = { email: user.email, password: user.password }
    post login_path, params: login_params
  end
end
