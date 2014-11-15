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
    @blocks = @volunteer.blocks.order(:day, :start_time)
    # @blocks.sort_by &:day
  end

  # GET /volunteers/1/edit
  def edit
    blocks_db = @volunteer.blocks;
    @blocks = Array.new(7) { Array.new(20) }

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

      respond_to do |format|
        if volunteer.save
          blocks = params.require(:blocks)
          blocks.each do |block_id|
            day, time = block_id.split('_').map(&:to_i)
            b = Block.find_by day: day, start_time: time
            c = Confirmation.new(volunteer: volunteer, block: b, confirmed: false)
            c.save
            #volunteer.blocks << b
          end
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
      blocks = params.require(:blocks)

      confirmations = Confirmation.where volunteer: @volunteer
      confirmations.each do |c|
        unless blocks.include?(c)
          c.destroy
        end
      end

      blocks.each do |block_id|
        day, time = block_id.split('_').map(&:to_i)
        b = Block.find_by day: day, start_time: time
        unless confirmations.include?(b)
          Confirmation.new(volunteer: @volunteer, block: b, confirmed: false).save
        end
      end

      volunteer_params.each do |key, value|
        @volunteer[key] = value
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

  # PUT /volunteers/1/blocks/1
  def toggleConfirmation
    volunteer = Volunteer.find(params[:vid])
    block = Block.find(params[:bid])

    c = Confirmation.where(:block => block, :volunteer => volunteer).first
    c.confirmed = !c.confirmed
    if c.save
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 400
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
