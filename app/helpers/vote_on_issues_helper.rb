module VoteOnIssuesHelper
  def down_votes(issue)
    VoteOnIssue.getDnVoteCountOnIssue issue.id
  end

  def up_votes(issue)
    VoteOnIssue.getUpVoteCountOnIssue issue.id
  end
end
