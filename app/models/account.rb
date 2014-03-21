class Account < ActiveRecord::Base

  has_many :diabetics

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  validates_uniqueness_of :username
  validates_confirmation_of :password, :on => :create
  validates_length_of :password, :within => 5..40

  def authorized?(params)
    self.authenticate(params[:users][:password])
  end

end
