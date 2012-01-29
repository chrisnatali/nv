class Admin::ProductsController < AdminAreaController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @products = Product.paginate :page => params[:page], :per_page => 10
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @tags = Tag.find(:all)
  end

  def create
    @product = Product.new(params[:product])
    if(params[:tag_ids])
      @tags = Tag.find(params[:tag_ids])
      @product.tags = @tags
    end

    @product.save!
    flash[:notice] = 'Product was successfully created.'
    redirect_to :action => 'list'
  end

  def edit
    @product = Product.find(params[:id])
    @tags = Tag.find(:all)
  end

  def update
    @product = Product.find(params[:id])
    @product.tags = Tag.find(params[:tag_ids]) if params[:tag_ids]
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
