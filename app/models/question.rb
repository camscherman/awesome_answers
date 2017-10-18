class Question < ApplicationRecord
    # Like 'belongs_to', 'has_many' tells rails that Question is associated to the Answer model.
    # The first argument is the associated model in lower and pluralized. It is
    # by convention the model that holds the foreign_key (i.e. 'question_id')
    belongs_to :user

    has_many :answers, dependent: :destroy

    # 'dependent: :destroy' means that all of the dependent answers will be deleted, if the question is
    # deleted

    # 'dependent: :nullify' will de-associate all associated answers-- Their 'question_id' field
    # will be updated with a 'null' value.

    # 'has_many' adds many convenience methods:

#     collection
# collection<<(object, ...)
# collection.delete(object, ...)
# collection.destroy(object, ...)
# collection=(objects)
# collection_singular_ids
# collection_singular_ids=(ids)
# collection.clear
# collection.empty?
# collection.size
# collection.find(...)
# collection.where(...)
# collection.exists?(...)
# collection.build(attributes = {}, ...)
# collection.create(attributes = {})
# collection.create!(attributes = {})
# collection.reload

    # We can define validation here. They'll be checked before a model is saved to the database
    # If any of the rules fail, activeRecord will prevent saving the model and will put an error 
    # message on the instance. You can check if a model instance passes all validations with the
    # instance method '.valid?'

    validates(:title, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
    validates(:body, {
        presence:true,
        length: {minimum: 5, maximum: 2000}
    })
    validates(:view_count, numericality:{
        greater_than_or_equal_to: 0
    })

    validate :no_monkey

    # These are custom validations---their methods are below
    after_initialize :set_defauts
    before_validation :titleize_title

    # def self.recent(count)
        # order(created_at: :desc).limit(count)
    # end
# The following is just a short way to generate scope methods like above
    scope :recent, -> (count){ order(created_at: :desc).limit(count) }

    private
    def no_monkey
        if title.present? && title.downcase.include?('monkey')
            errors.add(:title, "should not have a monkey!🐵")
        end

    end
    
    def set_defauts
        # You can read any attribute inside a model's class, by just refering to it by name,
        # but you must prefix it with 'self' if you want to write to it.
        self.view_count ||= 0
        # same as self.view_count = view_count || 0
    end

    def titleize_title
        self.title = title.titleize if title.present?
    end
   
end
