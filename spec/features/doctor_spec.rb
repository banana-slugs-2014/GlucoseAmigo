require 'spec_helper'

describe "doctors" do
	let(:doctor) { create :doctor }
	let!(:pre_created_doctor) { create :doctor }
	let(:doc_attr) { attributes_for :doctor }
	let!(:pre_created_doc_attr) { attributes_for :doctor }

  describe "User can see base page" do
    it "by visting the doctors page" do
      visit doctors_path
      expect(page.status_code).to eq(200)
    end
  end

# #==================================================================
# #======================create questions============================
# #==================================================================

#   describe "User can visit a question creation page" do
#     it "by clicking on ask a question" do
#       visit root_path
#       click_on "Ask a question!"
#       expect(page.status_code).to eq(200)
#       expect(page).to have_content "Question"
#       expect(page).to have_css("form")
#     end

#     context "with valid parameters" do
#       it "should be able to create a new question" do
#         expect{
#           visit root_path
#           click_on "Ask a question!"
#           fill_in "question[title]", with: test_title
#           fill_in "question[content]", with: test_content
#           click_on "Create Question"
#         }.to change{Question.count}.by(1)
#         expect(page).to have_content test_title
#       end
#     end

#     context "with invalid parameters" do
#       it "title cannot be blank" do
#         expect{
#           visit root_path
#           click_on "Ask a question!"
#           fill_in "question[content]", with: test_content
#           click_on "Create Question"
#         }.to_not change{Question.count}.by(1)
#       end

#       it "content cannot be blank" do
#         expect{
#           visit root_path
#           click_on "Ask a question!"
#           fill_in "question[title]", with: test_title
#           click_on "Create Question"
#         }.to_not change{Question.count}.by(1)
#       end
#     end
#   end

# #==================================================================
# #=======================delete question============================
# #==================================================================

#   describe "User can delete their own question" do
#     it "by clicking on delete question" do
#       visit root_path
#       click_on "Ask a question!"
#       fill_in "question[title]", with: test_title
#       fill_in "question[content]", with: test_content
#       click_on "Create Question"
#       expect{
#         click_on "Delete Question"
#       }.to change{Question.count}.by(-1)
#       expect(page).to_not have_content(test_title)
#     end
#   end

#   describe "User cannot delete questions not by them or when logged out" do
#     it "should not see any 'delete' button on the page when logged out" do
#       visit root_path
#       click_on "Log Out"
#       expect(page).to_not have_content("Delete Question")
#     end
#   end

# #====================================================================
# #=========================edit question==============================
# #====================================================================

#   describe "User can edit an existing question" do

#     before(:each) do
#       visit root_path
#       click_on "Ask a question!"
#       fill_in "question[title]", with: test_title
#       fill_in "question[content]", with: test_content
#       click_on "Create Question"
#     end

#     it "by clicking on edit" do
#       visit root_path
#       click_on "Edit Question"
#       expect(page.status_code).to eq(200)
#       expect(page).to have_content "Edit your question"
#       expect(page).to have_css("form")
#     end

#     context "with valid inputs" do
#       it "should edit the question" do
#         visit root_path
#         click_on "Edit Question"
#         fill_in "question[title]", with: edit_title
#         fill_in "question[content]", with: edit_content
#         click_on "Update Question"
#         expect(page.status_code).to eq(200)
#         expect(page).to_not have_content(test_title)
#         expect(page).to_not have_content(test_content)
#         expect(page).to have_content(edit_title)
#         expect(page).to have_content(edit_content)
#       end
#     end

#     context "with invalid inputs" do
#       xit "should not edit the question with blank title" do
#         visit root_path
#         click_on "Edit Question"
#         fill_in "question[content]", with: edit_content
#         click_on "Update Question"
#         expect(page).to_not have_content(test_title)
#         expect(page).to_not have_content(test_content)
#         expect(page).to have_content(edit_title)
#         expect(page).to have_content(edit_content)
#       end

#       xit "should not edit the question with blank content" do
#         visit root_path
#         click_on "Edit Question"
#         fill_in "question[title]", with: edit_title
#         click_on "Update Question"
#         expect(page).to_not have_content(test_title)
#         expect(page).to_not have_content(test_content)
#         expect(page).to have_content(edit_title)
#         expect(page).to have_content(edit_content)
#       end
#     end

#   end

end