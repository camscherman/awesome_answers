class Answer < ApplicationRecord
  # When the Answer model was generated, it was given the 'question:references'
  # 'column' ( the actual column is 'question_id'). This automatically added the following line:
  belongs_to :question
  belongs_to :user
  # It tells rails that in the association beween Answer-Question, the answer holds the foreign_key 'question_id'.

  # 'belongs_to' adds a balidation that enforces that the association must exist.
  # You can disable it by providing the option 'optional:true'.

  # 'belongs_ot also adds several insatnce methods for our convenience:

# association
# association=(associate)
# build_association(attributes = {})
# create_association(attributes = {})
# create_association!(attributes = {})
# reload_association
validates :body, presence: :true

end
