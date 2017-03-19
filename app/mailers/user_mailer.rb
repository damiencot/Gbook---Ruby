class UserMailer < ApplicationMailer

  # Envoie le mail de confirmation
  # Parametres = L'utilisateurs a qui l'on souhaite confirmer l'email
  def confirm(user)
    @user = user
    # Le nom du site est mis dans une variable dans notre configuration rails, On récupère le hash :name
    mail(to: user.email, subject: 'Votre inscription sur le site' + Rails.application.config.site[:name])
  end


  def password(user)
    @user = user
    mail(to: user.email, subject: 'Réinitialisation de votre mot de passe ' + Rails.application.config.site[:name])
  end


end
