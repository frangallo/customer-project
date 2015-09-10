require 'json'

class UserList
  attr_accessor :customer_list, :result
  attr_reader :range, :longitude_origin_radian, :latitude_origin_radian

  def initialize(customer_list, range, latitude, longitude)
    @customer_list = import_list(customer_list)
    @range = range
    @latitude_origin = latitude
    @longitude_origin = longitude.abs
    @result = Array.new(@customer_list.length-1, nil)
  end

  def import_list(customer_list)
    File.readlines(customer_list).map!(&:chomp)
  end

  def compile_list
    within_range = []
    @customer_list.each do |user|
      long, lat = parse_user(user)
      result[JSON.parse(user)["user_id"]] = user if distance(long,lat)
    end
    result.compact
  end

  def parse_user(user)
    long = JSON.parse(user)["longitude"].to_f
    lat = JSON.parse(user)["latitude"].to_f
    [long,lat]
  end

  def distance(lon, lat)
    lon = lon.abs
    distance = Math::acos(Math::sin(to_radians(latitude_origin)) *Math::sin(to_radians(lat)) +
      Math::cos(to_radians(latitude_origin)) * Math::cos(to_radians(lat)) * Math::cos(to_radians((lon-longitude_origin))))

    distance = distance * 6371
    distance <= range ? true : false
  end


  def to_radians(degrees)
   degrees * (Math::PI / 180.0)
 end
end

u = UserList.new("customer.txt", 100, 53.3381985, 6.2592576)
puts u.compile_list
