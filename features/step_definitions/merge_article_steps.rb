Given /^there is a publisher "([^"]*)"$/ do |name|
  User.create!({:login => name,
                :password => "aaaaaaaa",
                :email => "#{name}@snow.com",
                :profile_id => 2,
                :name => name,
                :state => 'active'
               })
end

When /^there is article published by "([^"]*)" with title "([^"]*)"$/ do |login, title|
  user = User.find_by_login(login)
  article = Article.get_or_build_article(nil)
  article.user = user
  article.title = title
  article.body = "Some interesting content"
  article.save
  article.comments.build(:body => "Comment", :author => login)
  article.save
end

When /^I fill in "([^"]*)" with the id of "([^"]*)"$/ do |selector, title|
  article = Content.find_by_title(title)
  step %{I fill in "#{selector}" with "#{article.id}"}
end
Then /^a merge article should be created$/ do
  Article.last.body.should == "Some interesting contentSome interesting content"
end