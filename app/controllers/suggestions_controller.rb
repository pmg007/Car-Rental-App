class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.all
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @suggestion=Suggestion.find_by_id(params[:id])
  end

  # GET /suggestions/new
  def new
    @suggestion = current_user.suggestions.build()
  end

  # GET /suggestions/1/edit
  def edit
  end


  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = current_user.suggestions.new(suggestion_params)
    @suggestion.accepted = false
    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to home_dashboard_path, notice: 'Suggestion was successfully created.' }
        format.json { render home_dashboard_path, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @suggestion = Suggestion.find(params[:id])
    if (@suggestion.accepted == false)
    @suggestion.accepted = true
    @suggestion.save!
    redirect_to new_car_path(:suggestion => true, :location => @suggestion.location, :model => @suggestion.model, :manufacturer => @suggestion.manufacturer, :style => @suggestion.style), notice: 'Suggestion was successfully accepted.'
    else
      redirect_to suggestions_path, notice: 'Already approved'
    end

  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      # @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:suggestion, :model, :manufacturer, :style, :location)
    end
end
