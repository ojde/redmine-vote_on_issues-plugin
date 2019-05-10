class VoteOnIssuesController < ApplicationController
  # respond_to :html, :js

  #Authorize against global permissions defined in init.rb
  # ?? does prevent everythin below admin?
  # TODO - find out how this works
  #before_action :authorize_global
  #before_action :authorize

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

    @vote = VoteOnIssue.where(issue_id: params[:issue_id]).where(user_id: User.current.id).first

    if @vote
      if 0 != @iMyVote
        @vote.vote_val = @iMyVote
        @vote.save
      else
        @vote.destroy
      end
    else
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

  def show_voters
    @issue = Issue.find(params[:issue_id])
    @UpVotes = VoteOnIssue.getListOfUpVotersOnIssue(params[:issue_id])
    @DnVotes = VoteOnIssue.getListOfDnVotersOnIssue(params[:issue_id])
    # Auto loads /app/views/vote_on_issues/show_voters.js.erb
  end
end
