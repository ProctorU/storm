module FormErrorsHelper
  def error_message_on(object, field)
    return unless object.respond_to?(:errors) && object.errors.include?(field)
    errors = field_errors(object, field).join(', ')

    content_tag(:span, errors, class: 'form-field-error')
  end

  private

  def field_errors(object, field)
    object.errors[field]
  end
end
