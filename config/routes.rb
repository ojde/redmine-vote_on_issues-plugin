# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'vote_on_issues/cast_vote', :to => 'vote_on_issues#cast_vote'
get 'vote_on_issues/show_voters', :to => 'vote_on_issues#show_voters'
get 'vote_on_issues', :to => 'vote_on_issues#index'
