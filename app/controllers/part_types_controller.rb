class PartTypesController < ApplicationController

  # GET /types
  def index
    @types = Hash.new
    PartType.order('type_name ASC').each do |type|
      @types["#{type.type_name}"] = type.parts.count
    end
    @type_page = "active"
  end
end
