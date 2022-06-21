class ArticlesController < ApplicationController
  before_action(:getArticle, only: [:show, :edit, :update, :destroy])
  def show()
  end

  def index()
    @articles = Post.paginate(page: params[:page], per_page: 30)
  end

  def new
    @article = Article.new()
  end

  def create
    @article = Article.new(articleParams())
    @article.user_id = User.last.id
    if @article.save 
      flash[:notice] = "Article was created Successfully"
      redirect_to article_path(@article.id)
    else
      render "new"
    end
  end

  def funny
    @article = Article.new()
  end

  def edit
  end

  def update
    if (@article.update(articleParams()))
      flash[:notice] = "Article was updated successfully"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private def getArticle()
    @article = Article.find(params[:id])
  end

  private def articleParams()
    params.require(:article).permit(:title, :description)
  end
  

end
