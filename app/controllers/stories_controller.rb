class StoriesController < ApplicationController
  def introduction
  end

  def finish
    begin
      ActiveRecord::Migration.check_pending!
    rescue ActiveRecord::PendingMigrationError
      ActiveRecord::Migrator.current_version
      ActiveRecord::MigrationContext.new(Rails.root.join("db/migrate")).migrate
    end

    if current_user.respond_to?(:first_login)
      current_user.update(first_login: false)
    end
    
    redirect_to root_path
  end
end
