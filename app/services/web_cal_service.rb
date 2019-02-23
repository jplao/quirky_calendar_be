class WebCalService

  def get_holidays
    to_json("http://www.webcal.fi/cal.php?id=50&format=json&start_year=current_year&end_year=next_year&tz=America%2FDenver")
  end

  private
  def conn
    Faraday.new()
  end

  def to_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
