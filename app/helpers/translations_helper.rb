# TranslationsHelper
module TranslationsHelper
  def i18n_phrases
    {
      pagination: {
        fetching: t('pagination.fetching'),
        failed: t('pagination.failed')
      }
    }.to_json
  end
end
