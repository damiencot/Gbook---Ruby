module ImageConcern

  extend ActiveSupport::Concern

  module ClassMethods

    def has_image(field, options = {})
      options[:resize] = 150 if options[:resize].nil?

      attr_accessor "#{field}_file".to_sym
      validates "#{field}_file".to_sym, file: {ext: [:jpg, :png]}
      after_save "#{field}_after_upload".to_sym
      before_save "#{field}_before_upload".to_sym
      after_destroy_commit "#{field}_destroy".to_sym

      # il recupere la classe
      # Recupere l'id
      class_eval <<-METHODS, __FILE__, __LINE__ +1 # Pour le debug
        def #{field}_url
          '/uploads/' + [
            self.class.name.downcase.pluralize,
            id.to_s,
            '#{field}.jpg'
          ].join('/')
        end

        def #{field}_path
          # On trouve le chemin
          File.join(
              Rails.public_path,
              'uploads',
              self.class.name.downcase.pluralize,
              id.to_s,
              '#{field}.jpg'
          )
        end

        private
      
        def #{field}_before_upload
          # Si le chemin est valide
          if #{field}_file.respond_to?(:path) and self.respond_to?(:#{field})
            # Champ field mis a TRUE
            self.#{field} = true
          end
        end
      
        def #{field}_after_upload
          path = #{field}_path
          # Si field répond à path on estime que le fichier est mouvable
          if #{field}_file.respond_to? :path
            # On récupère le dossier du même nom
            dir = File.dirname(path)
            # Si le dossier existe pas, on le crée sinon(unlesse) on le passe juste en paramètre
            FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
            image = MiniMagick::Image.new(#{field}_file.path) do |b|
              b.resize '#{options[:resize]}x#{options[:resize]}^'
              b.gravity 'Center'
              b.crop '#{options[:resize]}x#{options[:resize]}+0+0'
            end
            image.format 'jpg'
            image.write path
          end
        end
      
        def #{field}_destroy
          # Trouve moi le dossier Parent(ID) de l'field
          dir = File.dirname(#{field}_path)
          FileUtils.rm_r(dir) if Dir.exist?(dir)
        end

      METHODS

    end

  end

end