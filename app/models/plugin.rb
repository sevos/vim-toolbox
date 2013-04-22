class Plugin < ActiveRecord::Base

  scope :waiting, -> { where(approved_at: nil) }
  scope :approved, -> { where.not(approved_at: nil) }

  def approve
    self.approved_at = Time.now
    save
  end

  def sync(github_api: Github)
    user, repo = repository.split("/")
    self.description = github_api.repos.get(user: user, repo: repo).description
    save
  end
end
