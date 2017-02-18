# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  url        :string
#  content    :string
#  sub_id     :integer
#  author_id  :integer
#

class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true

  belongs_to :sub

end
