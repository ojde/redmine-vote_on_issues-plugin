class VoteOnIssue < ActiveRecord::Base
  unloadable
  
  # Every vote belongs to a user and an issue
  belongs_to :user
  belongs_to :issue
  
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
  
end
