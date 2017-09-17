# TranslationsHelper
module TranslationsHelper
  def i18n_phrases
    {
      base: {
        copied: t('base.copied')
      },
      pagination: {
        fetching: t('pagination.fetching'),
        failed: t('pagination.failed')
      }
    }.to_json
  end
end
