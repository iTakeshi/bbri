# coding: utf-8

class PartsController < ApplicationController

  # GET /parts/register
  def new
  end

  # POST /parts/register
  def create
    require 'open-uri'

    @error_count = 0

    year = params[:year]
    html = Nokogiri::HTML(open("http://igem.org/Team_Parts?year=#{year}"))
    teams = html.css('table[id] td div a')

    teams.each do |team|
      team_record = Team.where(team_name: team.children[0].text.strip).first_or_create

      parts_page_url = team.attributes["href"].value.gsub(' ', '%20')
      parts_page = Nokogiri::HTML(open(parts_page_url))
      parts_tables = parts_page.css('.pgrouptable')
      next if parts_tables.empty?

      parts_tables.each do |parts_table|
        parts_table.css('tr').each do |part_info|
          next if part_info.css('td').empty?
          begin
            part_type_record = PartType.where(type_name: part_info.css('td')[3].children[0].text.strip).first_or_create
          rescue NoMethodError
            part_type_record = PartType.find(1)
          end
          begin
            part_identifier = part_info.css('a.noul_link').children[0].text.strip
          rescue NoMethodError
            @error_count += 1
            next
          end
          part_record = team_record.parts.create(
            part_year: year,
            part_type_id: part_type_record.id,
            part_identifier: part_identifier
          )
        end
      end
    end
    redirect_to '/'
  end

  # POST /search
  def search
    @query = params[:query]
    @right_part = Part.find_by_part_identifier("BBa_#{@query.gsub(/bba(\-|_)/i, '').upcase}")
    all_parts = Part.where("part_identifier like ?", "%#{@query}%")
    @page = (params[:page] ? params[:page].to_i : 1)
    @page_max = (all_parts.count.to_f / 25).ceil
    @parts = all_parts.order('id DESC').offset(25 * (@page - 1)).limit(25)
    @page_heading = "Search Result for \"#{@query}\""
    render :list
  end

  # GET /parts/:part_identifier
  def show
    @part = Part.find_by_part_identifier(params[:part_identifier])
  end
end
