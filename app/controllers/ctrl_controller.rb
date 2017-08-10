class CtrlController < ApplicationController
  before_action :auth, only: :index
  around_action :around_logger

  def para
    render plain: 'idパラメータ：' + params[:id]
  end

  def req_head2
    @headers = request.headers
  end

  def upload_procces
    # アップロードファイルを取得
    file = params[:upfile]
    # ファイルのベース名（パスを除いた部分）を取得
    name = file.original_filename
    # 許可する拡張子を定義
    perms = ['.jpg','.jpeg','.png','.gif']
    # 配列permsにアップロードファイルの拡張子に合致するものがあるか
    if !perms.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみです。'
    # アップロードファイルのサイズが1MB以下であるか
    elsif file.size > 1.megabyte
      result = 'ファイルサイズは1MBまでです。'
    else
      # /public/docsフォルダ配下にアップロードファイルを保存
      File.open("public/docs/#{name}", 'wb'){ |f| f.write(file.read) }
      result = "#{name}をアップロードしました。"
    end
    # 成功/エラーメッセージを保存
    render plain: result
  end

  # アップロードフォームを表示するためのupdbアクション
  def updb
    @author = Author.find(params[:id])
  end

  # [アップロード]ボタンクリック時に呼び出され、アップロード処理を実施
  def updb_procces
    @author = Author.find(params[:id])
    # アップロードファイルをデータベースに保存（失敗時は１番目のエラーのみ表示）
    if @author.update(params.require(:author).permit(:data))
      render plain: '保存に成功しました。'
    else
      render plain: @author.errors.full_messages[0]
    end
  end

  def show_photo
    # ルートパラメータが指定されている場合はその値を、さもなければ１をセット
    id = params[:id] ? params[:id] : 1
    # authorsテーブルからid値をキーにレコードを取得
    @author = Author.find(id)
    # photo列（バイナリ型）をレスポンスとして送出
    send_data @author.photo, type: @author.ctype, disposition: :inline
  end

  def get_xml
    @books = Book.all
    render xml: @books
  end

  def get_json
    @books = Book.all
    render json: @books
  end

  def cookie
    # テンプレート変数@emailにクッキー値をセット
    @email = cookies[:email]
  end

  def cookie_rec
    cookies[:email] = { value: params[:email], expires: 3.months.from_now, http_only: true }
    render plain: 'クッキーを保存しました。'
  end

  def index
    sleep 3
    render plain: 'indexアクションが実行されました。'
  end



  private
  def auth
    #認証に利用するユーザー名
    name = 'yyamada'
    passwd = '8cb2237d0679ca88db6464eac60da96345513964'
    #基本認証機能を実行（入力されたユーザー名/パスワードをname/passと比較）
    authenticate_or_request_with_http_basic('Railsbook') do |n, p|
      n == name && Digest::SHA1.hexdigest(p) == passwd
    end
  end


  def around_logger
    logger.debug('[Start]' + Time.now.to_s)
    yield
    logger.debug('[Finish]' + Time.now.to_s)
  end

end





