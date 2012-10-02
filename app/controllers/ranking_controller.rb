class RankingController < ApplicationController

  # GET /
  def index
    @hottest_parts = Array.new
    Review.find(:all).group_by{|r| r.part_id}.each do |k, v|
      @hottest_parts << [Part.find(k).part_identifier, v.count]
    end
    @hottest_parts.sort!{|a, b| b[1] <=> a[1]}
  end
end
