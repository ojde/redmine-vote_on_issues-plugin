require_relative '../test_helper'

class VoteOnIssuesTest < Redmine::IntegrationTest
  fixtures :projects,
           :users, :email_addresses, :user_preferences,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :issue_relations,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations,
           :workflows

  def setup
    super
    User.current = nil
    EnabledModule.create! project_id: 1, name: 'vote_on_issues'
  end

  def test_voting_should_require_auth
    post '/issues/1/vote_on_issue', params: { vote_val: 'vup' }
    assert_response 302
  end

  def test_voting
    log_user 'admin', 'admin'

    get '/issues/1'
    assert_response :success

    assert_difference 'VoteOnIssue.count' do
      post '/issues/1/vote_on_issue', params: { vote_val: 'vup', format: :js }
      assert_response :ok
    end

    get '/issues/1'
    assert_response :success
    assert_select 'span#vote_on_issues_nVotesUp', '1'
    assert_select 'span#vote_on_issues_nVotesDn', '0'

    assert_difference 'VoteOnIssue.count', -1 do
      delete '/issues/1/vote_on_issue', params: { format: :js }
      assert_response :ok
    end

    get '/issues/1'
    assert_response :success
    assert_select 'span#vote_on_issues_nVotesUp', '0'
    assert_select 'span#vote_on_issues_nVotesDn', '0'

    assert_difference 'VoteOnIssue.count' do
      post '/issues/1/vote_on_issue', params: { vote_val: 'vdn', format: :js }
      assert_response :ok
    end

    get '/issues/1'
    assert_response :ok
    assert_select 'span#vote_on_issues_nVotesUp', '0'
    assert_select 'span#vote_on_issues_nVotesDn', '1'
  end
end

