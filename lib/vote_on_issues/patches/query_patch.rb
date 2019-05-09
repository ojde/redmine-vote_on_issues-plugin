
module VoteOnIssues
  module Patches
    module QueryPatch

      def sum_votes_up(issue)
        if User.current.allowed_to?(:view_votes, nil, :global => true)
          VoteOnIssue.where(issue_id: issue.id).where('vote_val > 0').sum('vote_val')
        else
          '-'
        end
      end

      def sum_votes_dn(issue)
        if User.current.allowed_to?(:view_votes, nil, :global => true)
          VoteOnIssue.where(issue_id: issue.id).where('vote_val < 0').sum('vote_val')
        else
          '-'
        end
      end

      def sum_votes_up_and_dn(issue)
        if User.current.allowed_to?(:view_votes, nil, :global => true)
          VoteOnIssue.where(issue_id: issue.id).sum('vote_val')
        else
          '-'
        end
      end
    end
  end
end