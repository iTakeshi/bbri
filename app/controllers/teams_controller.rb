class TeamsController < ApplicationController

  # GET /teams
  def index
    @teams = Hash.new
    Team.all.each do |team|
      @teams["#{team.team_name}"] = team.parts.count
    end
  end
end
