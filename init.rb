require 'redmine'


Redmine::Plugin.register :vote_on_issues do
  name 'Vote On Issues'
  description 'This plugin allows to up- and down-vote issues.'
  version '1.0.3'
  url 'https://github.com/ojde/redmine-vote_on_issues-plugin'
  author 'Ole Jungclaussen'
  author_url 'https://jungclaussen.com'

  requires_redmine  :version_or_higher => '2.6.10'

  project_module :vote_on_issues do
    permission :cast_votes, {:issues => :cast_vote }, :require => :loggedin
    permission :view_votes, {:issues => :view_votes}, :require => :loggedin
    permission :view_voters, {:issues => :view_voters}, :require => :loggedin
  end

  # permission for menu
  # permission :vote_on_issues, { :vote_on_issues => [:index] }, :public => true
  # menu :project_menu,
  #   :vote_on_issues,
  #   { :controller => 'vote_on_issues', :action => 'index' },
  #   :caption => :menu_title,
  #   :after => :issues,
  #   :param => :project_id,
  #   :if =>  Proc.new {
  #     User.current.allowed_to?(:view_votes, nil, :global => true)
  #   }
end

# Executed after Rails initialization, each time the classes are reloaded
Rails.configuration.to_prepare do
  require_dependency 'hooks'
  require_dependency 'vote_on_issue'
  require_dependency 'voi_query_column'

  # patch issue_query to allow columns for votes
  issue_query = (IssueQuery rescue Query)
  issue_query.add_available_column(VoiQueryColumn.new(:sum_votes_up, :sortable => '(SELECT abs(sum(vote_val)) FROM vote_on_issues WHERE vote_val > 0 AND issue_id=issues.id )'))
  issue_query.add_available_column(VoiQueryColumn.new(:sum_votes_dn, :sortable => '(SELECT abs(sum(vote_val)) FROM vote_on_issues WHERE vote_val < 0 AND issue_id=issues.id )'))
  issue_query.add_available_column(VoiQueryColumn.new(:sum_votes_up_and_dn, :sortable => '(SELECT sum(vote_val) FROM vote_on_issues WHERE issue_id=issues.id )'))
  Issue.send(:include, VoteOnIssues::Patches::QueryPatch)

  class VoteOnIssuesListener < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline =>  <<-END
        <%= stylesheet_link_tag 'view_issues_vote', :plugin => 'vote_on_issues' %>
        <%= javascript_include_tag 'view_issues_vote', :plugin => 'vote_on_issues' %>
      END
  end
end