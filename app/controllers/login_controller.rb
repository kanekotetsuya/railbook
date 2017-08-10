class LoginController < ApplicationController
  skip_before_action :check_login


  # ログインボタンのクリック時に実行されるアクション
  def auth
    # 入力値に従ってユーザー情報を取得
    usr = User.find_by(username: params[:username])
    # ユーザー情報が存在し、認証（authenticate）に成功したら
    if usr && usr.authenticate(params[:password]) then
      reset_session
      session[:usr] = usr.id
      redirect_to params[:referer]
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザー名/パスワードが間違っています。'
      redirect_to 'index'
    end
  end

end
