class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    #@pictures = Picture.all
    @pictures = Picture.order('position ASC')
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show

    #render plain: @myimage
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        create_image_tumb(@picture)

        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def uppos

    pic_hash = {}
    i = 0
    params.each do |key, value|
      if (numeric? key)
        i +=1
        pic_hash[key] = i
      end
    end

    pic_hash.each do |p|
      #puts p
      pic = Picture.find(p[0])
      pic.position = p[1]
      pic.save
      #logger.info(p)
    end
    redirect_to action: 'index', controller: 'pictures'
    #render plain: pic_hash
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        create_image_tumb(@picture)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def numeric? n
      Float(n) != nil rescue false
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:name, :description, :image)
    end

    def create_image_tumb img
      @myimage = MiniMagick::Image.open(@picture.image.path)
      @myimage.resize "200x300"
      file_path_dir = File.dirname(@picture.image.path)
      file_ext = File.extname(@picture.image.path)
      file_name = File.basename(@picture.image.path, file_ext)
      file_name_mini = file_name + "_tumb" + file_ext
      mini_file = File.join(file_path_dir, file_name_mini)
      FileUtils.cp @myimage.path, mini_file
      #@picture.image_file_name_mini = file_name_mini

      @image_tumb = File.dirname(@picture.image.url) + '/' + File.basename(@picture.image.url, File.extname(@picture.image.url)) + '_tumb' + File.extname(@picture.image.url)
    end
end
