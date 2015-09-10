require 'json'

class UserList
  attr_reader :range, :longitude_origin, :latitude_origin, :customer_list

  def initialize(customer_list, range, latitude, longitude)
    @customer_list = import_list(customer_list)
    @range = range
    @latitude_origin = latitude
    @longitude_origin = longitude.abs
    @result = Array.new(@customer_list.length-1, nil)
  end

  def compile_list
    @customer_list.each do |user|
      long, lat = parse_user_coords(user)
      id = parse_user_id(user)
      @result[id] = [parse_user_name(user), id] if distance(long,lat)
    end
    @result.compact
  end

  private

  def import_list(customer_list)
    File.readlines(customer_list).map!(&:chomp)
  end

  def parse_user_name(user)
    parse_json(user,"name")
  end

  def parse_user_coords(user)
    long = parse_json(user, "longitude").to_f
    lat = parse_json(user, "latitude").to_f
    [long,lat]
  end

  def parse_user_id(user)
    parse_json(user,"user_id")
  end

  def parse_json(user,key)
    JSON.parse(user)[key]
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

customer_records = UserList.new("customer.txt", 100, 53.3381985, 6.2592576)
p customer_records.compile_list
