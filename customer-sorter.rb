require 'json'

class UserList
  attr_accessor :customer_list
  attr_reader :range

  def initialize(customer_list, range)
    @customer_list = import_list(customer_list)
    @range = range
  end

  def import_list(customer_list)
    File.readlines(customer_list).map!(&:chomp)
  end

  def compile_list
    within_range = []
    @customer_list.each do |

  def distance(lat1, lon1, lat2, lon2)
    lat1, lon1, lat2, lon2 = [lat1, lon1, lat2, lon2].map!{|el| to_radians(el)}

    distance = Math::acos(
      Math::sin(lat1)*Math::sin(lat2) +
      Math::cos(lat1)*Math::cos(lat2) *
      Math::cos(lon2-lon1)
    ) * 6371

    disance <= range ? true : false
  end

  private

  def self.to_radians(degrees)
   degrees * Math::PI / 180.0
 end
end

u = UserList.new("customer.txt")
p u.customer_list
