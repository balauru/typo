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
      @result = @article1.dup
      @result.id, result.guid = nil
      @result.body += @article2.body
      @result.save
    end
    @result
  end
end