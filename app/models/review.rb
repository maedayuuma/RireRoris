class Review < ApplicationRecord
    belongs_to :item
    belongs_to :customer

    before_save :empty_comment
    validates :all_rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true


    private

    def empty_comment
        if comment.nil?
            self.comment = ""
        end
    end
end
