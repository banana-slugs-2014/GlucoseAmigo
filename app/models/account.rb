class Account < ActiveRecord::Base

  has_many :diabetics

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  # there is a way around this.
  after_validation { self.errors.messages.delete(:password_digest) }

  validates_uniqueness_of :email
  validates_presence_of :username, :email
  validates_length_of :password, :within => 5..40
  validates_format_of :email, :with => /^\w+[\.\w\-]*@\w+\.\w{2,5}$/

  validates_presence_of :password,
                        :message => Proc.new { |error, attributes|
                          "#{attributes[:value]} can't be blank."
                        }


  # this is authenticate not authorize, this method is unnecessary. use authenticate in the controller
  def authorized?(params)
    !!self.authenticate(params[:account][:password])
  end

  # we need to turn this into a model/active record validation, I can help you with that.
  def confirmed?(params)
    params[:account][:password_confirmation] == params[:account][:new_password]
  end

end
