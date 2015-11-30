class String 
  def is_integer?
    self.to_i.to_s == self
  end
end


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
  @movies = Movie.all 
end


Then /^I should see "(.*?)" before "(.*?)"/ do |e1, e2|
  regexp = /#{e1}.*#{e2}/m  #/m means match across newlines
  page.body.should =~ regexp
end

When /^I check the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|
      check("ratings_#{rating}")
  end
end

When /^I uncheck the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|
      uncheck("ratings_#{rating}")
  end
end

Then /^I should see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |text|  
     page.find('#movies').has_content?("<td>#{text}<td>")
  end

end

Then /^I should not see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |text|
    page.find('#movies').has_no_content?("<td>#{text}<td>")
  end
end

When(/^I check all movies$/) do
  @movies.pluck(:rating).uniq.each do |rating| 
    check("ratings_#{rating}")
  end
end
 
Then /^I should see all the movies/ do
  @movies.pluck(:rating).each do |text|
    page.find('#movies').has_content?("<td>#{text}<td>")
  end
end


