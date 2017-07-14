# SettingsCreator
class SettingsCreator
  def self.execute
    Setting.create unless Setting.count.positive?
  end
end
