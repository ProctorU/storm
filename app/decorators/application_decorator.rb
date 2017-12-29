# ApplicationDecorator
#
# The ApplicationDecorator is designed to be the parent class for all
# decorators. Shared methods across decorators can be defined here.
class ApplicationDecorator < Draper::Decorator
  delegate_all

  def formatted_time(attribute)
    time = send(attribute)
    return unless time.present?

    h.local_time(time, '%B %e, %Y at %l:%M%P')
  end
end
