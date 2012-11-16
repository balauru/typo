require "spec_helper"

describe Admin::ContentHelper do
  let(:article) { mock_model(Article, :id => 42) }

  describe "show_merge" do
    subject { helper.show_merge(article) }

    context "with admin connection" do
      before :each do
        helper.stub_chain(:current_user, :admin?).and_return(true)
      end

      it { should_not be_empty }
    end

    context "when publisher connection" do

      before :each do
        helper.stub_chain(:current_user, :admin?).and_return(false)
      end

      it { should be_nil }
    end
  end
end