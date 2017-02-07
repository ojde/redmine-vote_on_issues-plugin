module VoteOnIssuesHooks
  class Hooks < Redmine::Hook::ViewListener
      # :partial => <path>
      #     path is relative to plugins/plugin_name/app/views
      #     If we use ... => 'abc/test'
      #       Html File expected is: /plugins/plugin_name/app/views/abc/_test.erb
      #     Otherwise we'll get a 404 on the whole view
      render_on :view_issues_show_details_bottom,
                :partial => 'view_issues/show_details_bottom'

      # Writing Html code directly
      # render_on :view_issues_show_details_bottom, :inline => <<-END
        # <div class="splitcontent">
          # <div class="splitcontentleft">
            # <div class="status attribute">
              # <div class="label">Votes:</div>
              # <div class="value">Ha!</div>
            # </div>
          # </div>
        # </div>
        # END
  end
end

# CONTEXT redmine 3.2.0, view_issues_show_details_bottom
# <div class="attributes">
#   <div class="splitcontent">
#     <div class="splitcontentleft">
#       <div class="status attribute">
#         <div class="label">Status:</div>
#         <div class="value">New</div>
#       </div>
#       <div class="priority attribute">
#         <div class="label">Priority:</div>
#         <div class="value">Normal</div>
#       </div>
#       <div class="assigned-to attribute">
#         <div class="label">Assignee:</div>
#         <div class="value">-</div>
#       </div>
#     </div>
#     <div class="splitcontentleft">
#       <div class="start-date attribute">
#         <div class="label">Start date:</div>
#         <div class="value"></div>
#       </div>
#       <div class="due-date attribute">
#         <div class="label">Due date:</div>
#         <div class="value"></div>
#       </div>
#       <div class="progress attribute">
#         <div class="label">% Done:</div>
#         <div class="value"><table class="progress progress-0"><tr><td style="width: 100%;" class="todo"></td></tr></table><p class="percent">0%</p></div>
#       </div>
#     </div>
#   </div>
#   ------ INSERT -------- 
#   <div class="splitcontent">
#     <div class="splitcontentleft">
#       <div class="status attribute">
#         <div class="label">Votes:</div>
#         <div class="value">Ha!</div>
#       </div>
#     </div>
#   </div>
#   ------ INSERT -------- 
# </div>
