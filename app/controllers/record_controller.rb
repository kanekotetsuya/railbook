class RecordController < ApplicationController

  def where
    @books = Book.where(publish: '技術評論社')
    render 'hello/list'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
    render 'hello/list'
  end

  def not
    @book = Book.where.not(isbn: params[:id])
    render 'books/index'
  end

  def where_or
    @books = Book.where(publish: '技術評論社').or(Book.where('price > 2000'))
    render 'hello/list'
  end

  def order
    @books = Book.where(publish: '技術評論社').order(published: :desc)
    render 'hello/list'
  end

  def reorder
    @books = Book.order(:publish).order(:price)
    render 'books/index'
  end

  def select
    @books = Book.where('price >= 2000').select(:title, :price)
    render 'hello/list'
  end

  def select2
    @pubs = Book.select(:publish).distinct.order(:publish)
  end

  def offset
    @books = Book.order(published: :desc).limit(3).offset(4)
    render 'hello/list'
  end

  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
    render 'hello/list'
  end

  def last
    @book = Book.order(published: :desc).last
    render 'books/show'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having('AVG(price) >= ?', 2500)
    render 'record/groupby'
  end

  def where2
    @books = Book.all
    @books.where!(publish: '技術評論社')
    @books.order!(:published)
    render 'books/index'
  end

  def none
    case params[:id]
      when 'all'
        @books = Book.all
      when 'new'
        @books = Book.order('published DESC').limit(5)
      when 'cheap'
        @books = Book.order(:price).limit(5)
      else
        @books = Book.none
    end

    render 'books/index'
  end

  def pluck
    render plain: Book.where(publish: '技術評論社').pluck(:title, :price)
  end

  def exists
    flag = Book.where(publish: '新評論社').exists?
    render plain: "存在するか? : #{flag}"
  end

  def scope
    @books = Book.gihyo.top10
    render 'hello/list'
  end

  def def_scope
    render plain: Review.all.inspect
  end

  def count
    cnt = Book.where(publish: '技術評論社').count
    render plain: "#{cnt}件です。"
  end

  def average
    price = Book.where(publish: '技術評論社').average(:price)
    render plain: "平均価格は#{price}です。"
  end

  def groupby2
    @books = Book.group(:publish).average(:price)
  end

  def update_all
    cnt = Book.where(publish: '技術評論社').update_all(publish: 'Gihyo')
    render plain: "#{cnt}件のデータを更新しました。"
  end

  def update_all2
    cnt = Book.order(:publish).limit(5).update_all('price = price * 0.8')
    render plain: "#{cnt}件のデータ"
  end

  def destroy_all
    Book.where.not(publish: '技術評論社').destroy_all
    render plain: '削除完了'
  end

  def transact
    Book.transaction do
      b1 = Book.new({isbn: '978-4-7741-5067-3', title: 'Rubyポケットリファレンス', price: 2580, publish: '技術評論社', published: '2017-04-17'})
      b1.save!
      # raise '例外発生:処理はキャンセルされました。'
      b2 = Book.new({isbn: '978-4-7741-5067-5', title: 'Tomcatポケットリファレンス', price: 2500, publish: '技術評論社', published: '2015-05-10'})
      b2.save!
    end
    render plain: 'トランザクションは成功しました。'
    rescue => e
    render plain: e.message
  end

  def enum_rec
    @review = Review.find(1)
    @review.published!
    render plain: 'ステータス：' + @review.status
  end

  #検索フォームを表示する
  def keywd
    @search = SearchKeyword.new
  end

  #検索ボタンがクリックされた場合に呼び出されるアクション
  def keywd_process
    #入力値を元にモデルオブジェクトを生成
    @search = SearchKeyword.new(params.require(:search_keyword).permit(:keyword))
    #検証を実施（正常時はキーワードを、エラー時はエラーメッセージを表示）
    if @search.valid?
      render plain: @search.keyword
    else
      render plain: @search.errors.full_message[0]
    end
  end

  def belongs
    @review = Review.find(3)
  end

  def has_many_through
    @user = User.find_by(username: 'isatou')
  end

  def cache_counter
    @user = User.find(1)
    render plain: @user.reviews.size
  end

  def memorize
    @book = Book.find(1)
    # 書籍情報に関連するメモを登録
    @memo = @book.memos.build({ body: 'あとで買う' })
    if @memo.save
      render plain: 'メモを作成しました。'
    else
      render plain: @memo.errors.full_message[0]
  end

  def assoc_join
    @books = Book.joins(:reviews, :authors).order('books,title, reviews.updated_at').select('books.*, reiews.body, author.name')
  end

  def assoc_join2
    @books = Book.joins(reviews: :user).select('books.*, reviews.body, users.username')
  end

  def assoc_join3
    @books = Book.joins('LEFT OUTER JOIN reviews ON reviews.book_id = books.id').select('books.*, reviews.body')
  end

  def assoc_join4
    @books = Book.left_outer_joins(:reviews).select('books.*, reviews.body')
    render 'assoc_join3'
  end

  def assoc_include
    @books = Book.includes(:reviews).all
  end

end







