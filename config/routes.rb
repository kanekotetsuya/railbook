Rails.application.routes.draw do

  get 'hello/index', to: 'hello#index' #URLとcontroller,actionが同じ場合下記のように省略できる
  get 'hello/view'
  get 'hello/list'
end
