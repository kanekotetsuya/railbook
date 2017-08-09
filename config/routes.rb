Rails.application.routes.draw do

  resources :members
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books

  # 第2章
  get 'hello/index', to: 'hello#index'
  get 'hoge/piyo', to: 'hello#index'
  get 'hello/index'
  get 'hello/view'
  get 'hello/nothing'
  get 'hello/app_var'
  get 'hello/list'

  # 第4章
  get 'view/keyword'
  post 'keyword/search'
  get 'view/form_tag'
  get 'view/form_for'
  get 'view/field'
  get 'view/html5'
  get 'view/select'
  get 'view/col_select'
  get 'view/group_select'
  get 'view/select_tag'
  get 'view/select_tag2'
  get 'view/col_select2'
  get 'view/group_select2'
  get 'view/dat_select'
  get 'view/col_radio'
  get 'view/fields'
  get 'view/simple_format'
  get 'view/truncate'
  get 'view/excerpt'
  get 'view/highlight'
  get 'view/conc'
  get 'view/sanitize'
  get 'view/format'
  get 'view/link'
  get 'view/linkif'
  get 'login/index'
  get 'login/info'
  get 'view/current'
  get 'view/detail'
  get 'view/mailto'
  get 'view/image_tag'
  get 'view/audio'
  get 'view/video'
  get 'view/helper'
  get 'view/helper2'
  get 'view/helper3'
  get 'view/multi'
  get 'view/relation'
  get 'view/download'
  get 'view/quest'
  get 'view/nest'
  get 'view/partial_basic'
  get 'view/partial_param'
  get 'view/partial_col'
  get 'view/partial_spacer'

  # 第5章
  get 'record/where'
  get 'record/keyword'
  post 'record/ph1'
  get 'record/not(/:id)' => 'record#not'
  get 'record/where_or'
  get 'record/order'
  get 'record/reorder'
  get 'record/select'
  get 'record/select2'
  get 'record/offset'
  get 'record/page(/:id)' => 'record#page'
  get 'record/last'
  get 'record/groupby'
  get 'record/havingby'
  get 'record/where2'
  get 'record/none(/:id)' => 'record#none'
  get 'record/scope'
  get 'record/def_scope'
  get 'record/count'
  get 'record/average'
  get 'record/groupby2'
  get 'record/literal_sql'
  get 'record/update_all'
  get 'record/update_all2'
  get 'record/destroy_all'
  get 'record/transact'
  get 'record/enum_rec'
  get 'record/keywd'
  post 'record/keywd_process'
  get 'record/belongs'
  get 'record/has_many_through'
  get 'record/assoc_include'

end





