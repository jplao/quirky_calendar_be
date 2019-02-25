class HolidaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :name, :url
end
