class TeamsController < ApplicationController

  # GET /teams
  def index
    @teams = Hash.new
    Team.order('lower(team_name) ASC').each do |team|
      @teams["#{team.team_name}"] = team.parts.count
    end
    @team_page = "active"
  end
end
