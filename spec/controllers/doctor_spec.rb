require 'spec_helper'

describe DoctorsController do
	let(:doctor) { create :doctor }
	let(:doc_attr) { attributes_for :doctor }

  context "#index" do
    it "should successfully render a page" do
    	get :index
      expect(response).to be_success
    end
  end

  context "#show" do
    it "should successfully render a page" do
    	get :show, id: doctor.id
      expect(response).to be_success
    end
    it "should display this specific doctor" do
      get :show, id: doctor.id
      expect(assigns(:doctor)).to eq(doctor)
    end
  end

  context "#new" do
    it "should successfully render a page" do
    	get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    it "should increase doctor count if doctor name and fax don't already exist" do
      expect{
        post :create, doctor: doc_attr
      }.to change{Doctor.count}.by(1)
    end
    it "should not increase doctor count if doctor name and fax already exists" do
      expect{
      	puts "===========doctor is=================="
      	p doctor
      	p doctor.name
      	p doctor.fax

        post :create, doctor: { name: doctor.name, fax: doctor.fax } #doctor: doc_attr#, id: question.id
      }.to change{Doctor.count}.by(0)
    end
  end
#     context "with valid attributes" do
#       it "should redirect" do
#         post :create, question: attribs, id: question.id
#         expect(response).to be_redirect
#       end

#       it "should increase Question count" do
#         expect{
#           post :create, question: attribs, id: question.id
#         }.to change{Question.count}.by(1)
#       end
#     end

end





#   context "#create" do
#     context "with valid attributes" do
#       it "should redirect" do
#         post :create, question: attribs, id: question.id
#         expect(response).to be_redirect
#       end

#       it "should increase Question count" do
#         expect{
#           post :create, question: attribs, id: question.id
#         }.to change{Question.count}.by(1)
#       end
#     end

#     context "with invalid attributes" do
#       it "should display error"
#       it "should not increase Question count" do
#         expect{
#           post :create, question: { title: '' }, id: question.id
#         }.to_not change{Question.count}.by(1)
#       end
#     end
#   end

#   context "#edit" do
#     it "should be ok" do
#       get :edit, id: question.id
#       expect(response).to be_ok
#     end

#     it "should assign question to @question" do
#       get :edit, id: question.id
#       expect(assigns(:question)).to eq(question)
#     end
#   end

#   context "#update" do
#     context "with valid attributes" do
#       it "should redirect" do
#         post :update, question: { title: "My title" }, id: question.id
#         expect(response).to be_redirect
#       end
#     end

#     context "with invalid attributes" do
#       it "should display an error"
#     end
#   end

#   context "#destroy" do
#     it "should redirect" do
#       delete :destroy, id: question.id
#       expect(response).to be_redirect
#     end

#     it "should change Question count by -1" do
#       expect{
#         delete :destroy, id: question.id
#       }.to change{Question.count}.by(-1)
#     end
#   end

#   context "create#vote" do

#     context "with positive values (upvote)" do
#       it "should increase vote count if it's the first time the user votes on the question" do
#         expect{
#         post :create_vote, :id => my_question, value: 1
#         }.to change{Vote.count}.by(1)
#       end
#     end

#     context "with positive values (upvote)" do
#       it "should not increase vote count if the user has already voted on the question" do
#         post :create_vote, :id => my_question, value: 1
#         expect{
#         post :create_vote, :id => my_question, value: 1
#         }.to change{Vote.count}.by(0)
#       end
#     end

#   end

# end