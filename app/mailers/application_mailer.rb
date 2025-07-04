class ApplicationMailer < ActionMailer::Base
  extend T::Sig

  default from: "no-reply@tdooner.com"
  layout "mailer"
end
