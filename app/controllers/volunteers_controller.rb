class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all
  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
  end

  # GET /volunteers/1/edit
  def edit
    blocks_db = @volunteer.blocks;
    @blocks = Array.new(7) { Array.new(10) }

    blocks_db.each do |block|
      @blocks[block.day][block.start_time] = true;
    end
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    if !params.has_key?(:blocks)
      respond_to do |format|
        format.html { redirect_to blocks_path, flash: {:error => 'Select at least one time slot.' } }
      end
    else
      volunteer = Volunteer.new(volunteer_params)

      blocks = params.require(:blocks)
      blocks.each do |block_id|
        day, time = block_id.split('_').map(&:to_i)
        b = Block.find_by day: day, start_time: time
        volunteer.blocks << b
      end

      respond_to do |format|
        if volunteer.save
          format.html { redirect_to blocks_path, notice: 'Thank you! Schedule was successfully submitted.' }
        else
          format.html { redirect_to blocks_path, flash: {:error => 'There was a problem submitting.' } }
        end
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    if !params.has_key?(:blocks)
      respond_to do |format|
        format.html { redirect_to blocks_path, flash: {:error => 'Select at least one time slot.' } }
      end
    else
      @volunteer.blocks.clear

      blocks = params.require(:blocks)
      blocks.each do |block_id|
        day, time = block_id.split('_').map(&:to_i)
        b = Block.find_by day: day, start_time: time
        @volunteer.blocks << b
      end

      respond_to do |format|
        if @volunteer.save
          format.html { redirect_to @volunteer, notice: 'Schedule was successfully updated.' }
        else
          format.html { redirect_to @volunteer, flash: {:error => 'There was a problem submitting.' } }
        end
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url, notice: 'Volunteer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:first_name, :last_name, :contact_number, :notes)
    end
end
