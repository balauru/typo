class Article::MergingArticles
  include Context

  def self.merge(id1, id2)
    article1 = Article.find(id1)
    article2 = Article.find(id2)
    Article::MergingArticles.new(article1, article2).merge
  end

  attr_reader :article1, :article2, :result

  def initialize(article1, article2)
    @article1 = article1
    @article2 = article2
  end

  def merge
    in_context do
      @article1.body += @article2.body
      @article2.comments.each do |comment|
        comment.update_attribute(:article_id, @article1.id)
      end

      @article1.save
      @article2.reload
      @article2.destroy
    end
    @article1
  end
end