class ApplicationMailer < ActionMailer::Base
  # "manimanisanpo" というサービス名にしておくと自然です
  default from: "manimanisanpo <no-reply@manimanisanpo.onrender.com>"
  layout "mailer"
end
