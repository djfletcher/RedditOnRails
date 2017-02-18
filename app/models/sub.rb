# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  moderator_id :integer          not null
#  title        :string           not null
#  description  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base

  validates :moderator_id, :title, presence: true

  belongs_to :moderator,
    class_name: :User

  has_many :posts

end
