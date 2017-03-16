class FileValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value
      if value.respond_to? :path
        # Si l'extension de mon fichier n'est pas inclus dans mon tableau
        unless options[:ext].include? File.extname(value.path).delete('.').to_sym
          record.errors[attribute] << "is not a valid file (#{options[:ext].join(',')})"
        end
      else
        record.errors[attribute] << (options[:message] || 'is not a file')
      end
    end
  end

end