require "spec_helper"

describe Article::MergingArticles do
  describe "merge" do
    let(:comment1) { Comment.new }
    let(:comment2) { Comment.new }
    let(:article1) {
      Article.new(:body => "body1 ", :title => "some title", :user_id => 24, :comments => [comment1])
    }
    let(:article2) { mock_model(Article, :body => "body2", :comments => [comment2]) }

    before :each do
      Article.stub(:find).with(42).and_return(article1)
      Article.stub(:find).with(43).and_return(article2)

      article1.should_receive(:save).once
      article2.should_receive(:destroy).once

      comment2.should_receive(:save).once
    end

    subject { Article::MergingArticles.merge(42, 43) }

    its(:body) { should == "body1 body2" }

    its(:user_id) { should == 24 }

    its(:comments) { should include(comment1) }

    its(:title) { should == "some title" }
  end
end