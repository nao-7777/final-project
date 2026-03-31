class StoriesController < ApplicationController
  def introduction
  end

  def finish
    begin
      # 1. 工事（マイグレーション）を実行
      ActiveRecord::MigrationContext.new(Rails.root.join("db/migrate")).migrate
      
      # 2. カラム情報をリセットして最新の状態を読み込ませる
      User.reset_column_information 
    rescue => e
      logger.error "Migration failed: #{e.message}"
    end
  
    # 3. 再認識させた後なら、first_login が確実に「見える」ようになる
    if current_user.respond_to?(:first_login)
      current_user.update(first_login: false)
    end
    
    redirect_to root_path
  end
end
