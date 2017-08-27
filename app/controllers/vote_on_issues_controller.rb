class VoteOnIssuesController < ApplicationController
  # respond_to :html, :js
  unloadable

  before_filter :find_issue_by_id
  before_filter :authorize

  def create
    if 'vup' == params[:vote_val]
      @iMyVote = 1
    elsif 'vdn' == params[:vote_val]
      @iMyVote = -1
    else
      raise 'invalid vote_val parameter'
    end

    if @vote = find_vote
      @vote.vote_val = @iMyVote
      @vote.save
    else
      @vote = VoteOnIssue.new
      @vote.user_id  = User.current.id
      @vote.issue_id = params[:issue_id]
      @vote.vote_val = @iMyVote
      @vote.save
    end

    # Auto loads /app/views/vote_on_issues/cast_vote.js.erb
  end

  def show_voters
    @issue = Issue.find(params[:issue_id])
    @UpVotes = VoteOnIssue.getListOfUpVotersOnIssue(params[:issue_id])
    @DnVotes = VoteOnIssue.getListOfDnVotersOnIssue(params[:issue_id])
    # Auto loads /app/views/vote_on_issues/show_voters.js.erb
  end

  def destroy
    if vote = find_vote
      vote.destroy
    end
    respond_to do |format|
      format.js do
        @iMyVote = 0
        render 'create'
      end
    end
  end

  private

  def find_issue_by_id
    @issue = Issue.find(params[:issue_id])
    raise Unauthorized unless @issue.visible?
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_vote
    VoteOnIssue.where(issue_id: @issue.id, user_id: User.current.id).first
  end
end
