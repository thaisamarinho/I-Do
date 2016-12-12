class AdminMailer < ApplicationMailer
  def notify_admin(admin)
    @admin   = admin
    @wedding = Wedding.find(@admin.wedding)

    mail(to: @admin.email, subject:
    'You got an invitation to Join a wedding plan!')
  end

  def notify_admin_user(admin)
    @admin   = admin
    @wedding = Wedding.find(@admin.wedding)

    mail(to: @admin.email, subject:
    'You got an invitation to Join a wedding plan!')
  end
end
