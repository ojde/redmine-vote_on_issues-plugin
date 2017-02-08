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
    ,sImgUp : ''
    ,sImgDn : ''
    
    // ALL VOTES
    , showVotesOnIssue: function(nVotesUp, nVotesDn){
        $('#vote_on_issues_nVotesUp').html(nVotesUp);
        $('#vote_on_issues_nVotesDn').html(nVotesDn);
    }
    
    // LIST OF VOTERS
    , isListOfVotersOpen : function() {
        return('none' != $('#vote_on_issues-issue-voters').css('display'));
      }
    , clearListOfVoters : function() {
        var ListTbody = $('#vote_on_issues-issue-voters-list');
        ListTbody.html('');
    }
    , addToListOfVoters : function(vote_val, sVoter) {
        $('#vote_on_issues-issue-voters-list').append(
            '<tr><td>'
            +(vote_val > 0 ? this.sImgUp : this.sImgDn)
            +'</td><td><span data-vote-val="'+vote_val+'">'
            +sVoter
            +'</span></td></tr>'
        );
    }
    , showListOfVoters : function() {
        var ListBox = $('#vote_on_issues-issue-voters');
        var Anchor  = $('#vote_on_issues-link-voters');
        
        ListBox.css({
            top:  Anchor.position().top,
            left: Anchor.position().left
        });
        
        if('none' == ListBox.css('display')){
            var that = this;
            $(document).on('click.vote_on_issues-ListBox', function() {
                $(document).off('click.vote_on_issues-ListBox');
                that.hideListOfVoters();
            });
            ListBox.on('click.vote_on_issues-ListBox', function(e) {
                e.stopPropagation(); // This is the preferred method.
                return false;        // This should not be used unless you do not want
                                     // any click events registering inside the div
            });  
            ListBox.show();
        }
    }
    , hideListOfVoters : function() {
        var ListBox = $('#vote_on_issues-issue-voters');
        if('none' != ListBox.css('display')){
            $(document).off('click.vote_on_issues-ListBox');
            ListBox.off('click.vote_on_issues-ListBox');
            ListBox.hide();
        }
        this.clearListOfVoters();
    }
    
    // MY VOTE
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
