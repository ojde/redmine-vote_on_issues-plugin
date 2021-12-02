class VoteOnIssue < ActiveRecord::Base
  unloadable

  # Every vote belongs to a user and an issue
  belongs_to :user
  belongs_to :issue

  scope :left_join_user, -> { joins("LEFT JOIN users ON users.id = vote_on_issues.user_id").select("users.login") }
  scope :up_voters,      -> { select(:vote_val).where("vote_val > ?", 0) }
  scope :down_voters,    -> { select(:vote_val).where("vote_val < ?", 0) }
  scope :order_by_login, -> { order("users.login ASC") }

  def self.getMyVote(issue)
    iRet = 0
    begin
     @vote = VoteOnIssue.find_by!("issue_id = ? AND user_id = ?", issue.id, User.current.id)
     iRet = @vote.vote_val
    rescue ActiveRecord::RecordNotFound
     iRet = 0
    end
    iRet
  end

  def self.getUpVoteCountOnIssue(issue_id)
    where("issue_id = ? AND vote_val > 0", issue_id).count
  end

  def self.getDnVoteCountOnIssue(issue_id)
    where("issue_id = ? AND vote_val < 0", issue_id).count
  end

  def self.getListOfUpVotersOnIssue(issue_id)
    VoteOnIssue.up_voters.left_join_user.order_by_login
  end

  def self.getListOfDnVotersOnIssue(issue_id)
    VoteOnIssue.down_voters.left_join_user.order_by_login
  end
  
end
