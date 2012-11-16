require "spec_helper"

describe Article::MergingArticles do
  describe "merge" do
    let(:article1) { Article.new(:body => "body1 ", :user_id => 24) }
    let(:article2) { mock_model(Article, :body => "body2") }

    before :each do
      Article.stub(:find).with(42).and_return(article1)
      Article.stub(:find).with(43).and_return(article2)

      Article.any_instance.should_receive(:save).once
    end

    subject { Article::MergingArticles.merge(42, 43) }

    its(:body) { should == "body1 body2" }
  end
end