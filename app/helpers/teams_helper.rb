module TeamsHelper
  def show_badge_if_official(team)
    if team.is_official?
      '<i class="icon-ok-sign channel-avatar" data-toogle="tooltip"
        data-placement="top" data-original-title="Time Oficial"></i>'
    else
      ""
    end
  end
end
