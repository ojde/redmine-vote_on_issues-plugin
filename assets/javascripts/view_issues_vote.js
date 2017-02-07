/**
**
**
** @package 
** @author     Ole Jungclaussen
** @version    1.0.0
** @.copyright 2017, Ole Jungclaussen
**/
var vote_on_issues = {
    version : '1.0.0'
    , showVotesOnIssue: function(nVotesUp, nVotesDn){
        $('#vote_on_issues_nVotesUp').html(nVotesUp);
        $('#vote_on_issues_nVotesDn').html(nVotesDn);
    }
    , showMyVote : function(iUserVote){
        
        $('#vote_on_issues_MyVoteNil').hide();
        
        $('#vote_on_issues_MyVoteUpOn').hide();
        $('#vote_on_issues_MyVoteDnOn').hide();
        $('#vote_on_issues_MyVoteUpOff').hide();
        $('#vote_on_issues_MyVoteDnOff').hide();
        $('#vote_on_issues_MyVoteDelete').hide();
        
        if(!iUserVote){
            $('#vote_on_issues_MyVoteNil').show();
            $('#vote_on_issues_MyVoteUpOff').show();
            $('#vote_on_issues_MyVoteDnOff').show();
        }
        else if(iUserVote > 0){
            $('#vote_on_issues_MyVoteUpOn').show();
            $('#vote_on_issues_MyVoteDnOff').show();
            $('#vote_on_issues_MyVoteDelete').show();
        }
        else if(iUserVote < 0){
            $('#vote_on_issues_MyVoteDnOn').show();
            $('#vote_on_issues_MyVoteUpOff').show();
            $('#vote_on_issues_MyVoteDelete').show();
        }
    }
};
