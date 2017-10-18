class User < ApplicationRecord

    # 'has_secure_password'  is a built-in rails method that provides user authentication
    # features for the model its called in:
    # It adds attribute acessors fo the fields 'password' and 'password_confirmation'
    # It will automatically add a presence validator for the password field
    # When given a password, it will hash it and save as a password_digest in the 
    # database using the library 'bcrypt'.
    # It will also add the instance method 'authenticate' used to verify a password of a user.
    # If the given password is correct, it will return the user instance, otherwise it will
    # return false.
    has_secure_password
    
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
                        
    # The 'validates' option 'format:' takes a regular expression which is a way to 
    # verify that a string is formatted in a certain way.
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
