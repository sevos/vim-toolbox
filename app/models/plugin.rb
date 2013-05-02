class Plugin < ActiveRecord::Base
  has_many :installations, class_name: "PluginInstallation"
  has_many :users, :through => :installations

  scope :waiting, -> { where(approved_at: nil) }
  scope :approved, -> { where.not(approved_at: nil) }
  scope :recommended_order, -> {
    order("installations_count DESC", "approved_at DESC")
  }

  def approve
    self.approved_at = Time.now
    save
  end

  def sync(github_api: Github)
    user, repo = repository.split("/")
    self.description = github_api.repos.get(user: user, repo: repo).description
    save
  end

  def installations_count
    users.count
  end
end
