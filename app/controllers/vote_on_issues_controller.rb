class VoteOnIssuesController < ApplicationController
  # respond_to :html, :js
  unloadable

  #Authorize against global permissions defined in init.rb
  # ?? does prevent everythin below admin?
  # TODO - find out how this works
  #before_filter :authorize_global
  #before_filter :authorize
  
  def index
    @project = Project.find(params[:project_id])
    @votes = VoteOnIssue.all
  end

  def cast_vote
    @iMyVote = 0;
    if 'vup' == params[:vote_val]
      @iMyVote = 1
    elsif 'vdn' == params[:vote_val]
      @iMyVote = -1
    elsif 'nil' == params[:vote_val]
      @iMyVote = 0;
    end
    
    begin
      @vote = VoteOnIssue.find_by!("issue_id = ? AND user_id = ?", params[:issue_id], User.current.id)
      if 0 != @iMyVote
        @vote.vote_val = @iMyVote
        @vote.save
      else
        @vote.destroy
      end
    rescue ActiveRecord::RecordNotFound
      if 0 != @iMyVote
        @vote = VoteOnIssue.new
        @vote.user_id  = User.current.id
        @vote.issue_id = params[:issue_id]
        @vote.vote_val = @iMyVote
        @vote.save
      end
    end
    
    @nVotesUp = VoteOnIssue.getUpVoteCountOnIssue(params[:issue_id])
    @nVotesDn = VoteOnIssue.getDnVoteCountOnIssue(params[:issue_id])

    @issue = Issue.find(params[:issue_id])
    
    # Auto loads /app/views/vote_on_issues/cast_vote.js.erb
  end
end
