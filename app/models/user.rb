class User < ApplicationRecord



  has_many :books, dependent: :destroy # Un utilisateurs a plusieurs livres et la suppression est lier aussi a posts
  has_many :posts, dependent: :destroy # Un utilisateurs a plusieurs photos

  # Les utilisateurs sont associés à plusieurs livres
  has_many :subscriptions
  has_many :followed_books, through: :subscriptions, source: :book


  has_secure_password
  # Génération d'un Token aléatoire
  has_secure_token :confirmation_token
  has_secure_token :recover_password


  #has_image :avatar
  mount_uploader :avatar, AvatarUploader
  validates :avatar, presence: true, on: :create





  # Règles de validation
  validates :username,
    format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'Ne doit contenir que des caractères alphanumériques ou des _'},
    #Le pseudo doit etre unique (les majuscules ne sont pas pris en compte)
    uniqueness: {case_sensitive: false}

  validates :email,
    format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/},
    #L'email doit etre unique
    uniqueness: {case_sensitive: false}




  def to_session
    {id: id}
  end

=begin

  attr_accessor :avatar_file

  validates :avatar_file, file: {ext: [:jpg, :png]}

  after_save :avatar_after_upload
  before_save :avatar_before_upload
  after_destroy_commit :avatar_destroy


  def avatar_path
    # On trouve le chemin
    File.join(
        Rails.public_path,
        self.class.name.downcase.pluralize,
        id.to_s,
        'avatar.jpg'
    )
  end


  def avatar_url
    #
    '/' + [
        self.class.name.downcase.pluralize,
        id.to_s,
        'avatar.jpg'
    ].join('/')
  end

  private

  def avatar_before_upload
    # Si le chemin est valide
    if avatar_file.respond_to? :path
      # Champ avatar mis a TRUE
      self.avatar = true
    end
  end

  def avatar_after_upload
    path = avatar_path
    # Si avatar répond à path on estime que le fichier est mouvable
    if avatar_file.respond_to? :path
      # On récupère le dossier du même nom
      dir = File.dirname(path)
      # Si le dossier existe pas, on le crée sinon(unlesse) on le passe juste en paramètre
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      image = MiniMagick::Image.new(avatar_file.path) do |b|
        b.resize '150x150^'
        b.gravity 'Center'
        b.crop '150x150+0+0'
      end
      image.format 'jpg'
      image.write path
    end
  end

  def avatar_destroy
    # Trouve moi le dossier Parent(ID) de l'avatar
    dir = File.dirname(avatar_path)
    FileUtils.rm_r(dir) if Dir.exist?(dir)
  end

=end


end
