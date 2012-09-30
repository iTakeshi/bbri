# coding: utf-8

class PartsController < ApplicationController
  before_filter :authorize, only: [:new, :create]

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
          begin
            part_description = part_info.css('td')[4].children[0].text.strip
          rescue NoMethodError
            part_description = ""
          end
          part_record = team_record.parts.create(
            part_year: year,
            part_type_id: part_type_record.id,
            part_identifier: part_identifier,
            part_description: part_description
          )
        end
      end
    end
    redirect_to '/'
  end

  # POST /search
  def search
    query = params[:query]
    @right_part = Part.find_by_part_identifier("BBa_#{query.gsub(/bba(\-|_)/i, '').upcase}")
    all_parts = Part.where("part_identifier like ?", "%#{query}%")
    @page = (params[:page] ? params[:page].to_i : 1)
    @page_max = (all_parts.count.to_f / 25).ceil
    @parts = all_parts.order('id DESC').offset(25 * (@page - 1)).limit(25)
    @page_heading = "Search Result for \"#{query}\""
    @pagenation_base_url = "/search?query=#{query}&page="
    render :list
  end

  # GET /parts/team_parts/:team_name
  def team_parts
    @team = Team.find_by_team_name(params[:team_name])
    all_parts = @team.parts
    @page = (params[:page] ? params[:page].to_i : 1)
    @page_max = (all_parts.count.to_f / 25).ceil
    @parts = all_parts.order('id DESC').offset(25 * (@page - 1)).limit(25)
    @page_heading = "Parts submitted by #{@team.team_name}"
    @pagenation_base_url = "/parts/team_parts/#{@team.team_name}?page="
    render :list
  end

  # GET /parts/type_parts/:type_name
  def type_parts
    @type = PartType.find_by_type_name(params[:type_name])
    all_parts = @type.parts
    @page = (params[:page] ? params[:page].to_i : 1)
    @page_max = (all_parts.count.to_f / 25).ceil
    @parts = all_parts.order('id DESC').offset(25 * (@page - 1)).limit(25)
    @page_heading = "#{@type.type_name} parts"
    @pagenation_base_url = "/parts/type_parts/#{@type.type_name}?page="
    render :list
  end

  # GET /parts/:part_identifier
  def show
    @part = Part.find_by_part_identifier(params[:part_identifier])
    @my_review = Review.where(part_id: @part.id, user_id: current_user.id, is_question: false)
    @my_questions = Review.where(part_id: @part.id, user_id: current_user.id, is_question: true)
  end
end
