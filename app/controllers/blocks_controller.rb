class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit]

  # GET /blocks
  # GET /blocks.json
  def index
    blocks_db = Block.all

    @blocks_count = Array.new(7) { Array.new(10) }
    @blocks = Array.new(7) { Array.new(10) }

    blocks_db.each do |block|
      @blocks[block.day][block.start_time] = block;
      @blocks_count[block.day][block.start_time] = block.volunteers.count
    end
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show
  end

  # GET /volunteers/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end
end
