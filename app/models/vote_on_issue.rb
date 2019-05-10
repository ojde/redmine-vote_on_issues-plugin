class VoteOnIssue < ActiveRecord::Base
  # Every vote belongs to a user and an issue
  belongs_to :user
  belongs_to :issue

  scope :up_vote, lambda { where('vote_val > 0') }
  scope :down_vote, lambda { where('vote_val < 0') }

  def self.getMyVote(issue)
    iRet = 0
    begin
      @vote = where(issue_id: issue.id).where(user_id: User.current.id).first
      iRet = @vote.vote_val if @vote
    end
    iRet
  end

  def self.getUpVoteCountOnIssue(issue_id)
    where(issue_id: issue_id).up_vote.count
  end

  def self.getDnVoteCountOnIssue(issue_id)
    where(issue_id: issue_id).down_vote.count
  end

  def self.getListOfUpVotersOnIssue(issue_id)
    where(issue_id: issue_id).up_vote.joins(:user).order('users.login ASC').pluck(:vote_val, 'users.login')
  end

  def self.getListOfDnVotersOnIssue(issue_id)
    where(issue_id: issue_id).down_vote.joins(:user).order('users.login ASC').pluck(:vote_val, 'users.login')
  end
end
