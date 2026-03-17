Rails.application.routes.draw do
  get 'stories/introduction'
  # 1. ルートパスをTopコントローラーのindexアクションに設定
  root 'top#index'

  # 2. デバイスの設定
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # 3. その他の設定（これらはそのままでOK）
  get 'top/index'
  resources :users

  # 4. 完了ページを表示するためのURL
  get 'signup_success', to: 'pages#signup_success'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get 'password_reset_success', to: 'pages#password_reset_success'

  # ストーリー導入ページ
  get 'welcome', to: 'stories#introduction', as: 'introduction'
  
  # 導入後に「次へ」を押したときのフラグ更新用（後で作ります）
  patch 'stories/finish', to: 'stories#finish', as: 'finish_story'
end
