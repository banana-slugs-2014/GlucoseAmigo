class Account < ActiveRecord::Base

  has_many :diabetics

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  after_validation { self.errors.messages.delete(:password_digest) }

  validates_uniqueness_of :email
  validates_presence_of :username, :email
  validates_confirmation_of :password, :on => :create,  :message => :"password.blank"
  validates_length_of :password, :within => 5..40

  validates_presence_of :password,
                        :message => Proc.new { |error, attributes|
                          "#{attributes[:value]} can't be blank."
                        }

  def authorized?(params)
    !!self.authenticate(params[:users][:password])
  end

end
