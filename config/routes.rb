# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
scope 'issues/:issue_id' do
  resource :vote_on_issue, only: [ :create, :destroy ]
  get 'vote_on_issues/show_voters', :to => 'vote_on_issues#show_voters'
  get 'vote_on_issues', :to => 'vote_on_issues#index'
end
