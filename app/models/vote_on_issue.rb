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

  def self.getListOfUpVotersOnIssue(issue_id)
    # this does load the users, but costly: One query for each user
      # where("issue_id = ? AND vote_val > 0", issue_id)
    # this does load the users, less costly: One query for all users
      # includes(:user).where("issue_id = ? AND vote_val > 0", issue_id)
      # where("issue_id = ? AND vote_val > 0", issue_id).includes(:user)
    # joins users successfully, but still execs one query for each user 
      # where("issue_id = ? AND vote_val > 0", issue_id).joins(:user)
    # This does what I want, but I'd love to find out how to do this in rails...
    find_by_sql( ["SELECT `vote_on_issues`.`vote_val` AS vote_val, `users`.`login` AS user_login FROM `vote_on_issues` LEFT JOIN `users` ON (`users`.`id` = `vote_on_issues`.`user_id`) WHERE (`issue_id` = ? AND `vote_val` > 0) ORDER BY user_login ASC", issue_id] )
  end
  
  def self.getListOfDnVotersOnIssue(issue_id)
    # see getListOfUpVotersOnIssue
    find_by_sql( ["SELECT `vote_on_issues`.`vote_val` AS vote_val, `users`.`login` AS user_login FROM `vote_on_issues` LEFT JOIN `users` ON (`users`.`id` = `vote_on_issues`.`user_id`) WHERE (`issue_id` = ? AND `vote_val` < 0) ORDER BY user_login ASC", issue_id] )
  end
  
end
