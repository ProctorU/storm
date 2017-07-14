# AppSetup
class AppSetup
  attr_reader(:current_user, :current_path)

  def initialize(current_user, current_path)
    @current_user = current_user
    @current_path = current_path
  end

  def required?
    return false if current_user.present?

    User.none? && browsing_required_path?
  end

  private

  def browsing_required_path?
    !safe_paths.include?(current_path)
  end

  def safe_paths
    [
      '/',
      '/users/sign-up',
      '/users'
    ]
  end
end
