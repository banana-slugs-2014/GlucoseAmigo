class Account < ActiveRecord::Base

  has_many :diabetics

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  after_validation { self.errors.messages.delete(:password_digest) }

  validates_uniqueness_of :email
  validates_presence_of :username, :email
  validates_length_of :password, :within => 5..40

  validates_presence_of :password,
                        :message => Proc.new { |error, attributes|
                          "#{attributes[:value]} can't be blank."
                        }

  def authorized?(params)
    !!self.authenticate(params['account']['password'])
  end

  def confirmed?(params)
    params['account']['password_confirmation'] == params['account']['new_password']
  end

end
