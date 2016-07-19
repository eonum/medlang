module MultiLanguageText
  def name locale
    return localized_field 'name', locale
  end
  def description locale
    return localized_field 'description', locale
  end

  def localized_field field, locale
    if(locale.to_s == 'en')
      return self[field + '_en']
    end
    return self[field + '_de']
  end

  def check_locale locale
    if(locale != 'en')
      locale = 'de'
    end
    return locale
  end
end
