class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :watch_conditions

  def watched_investigations
    watch_conditions.reduce(Investigation.none) do |scope, watch_condition|
      scope.or(watch_condition.matching_investigations)
    end
  end
end
