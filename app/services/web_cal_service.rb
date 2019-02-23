class WebCalService

  def get_holidays
    conn = Faraday.new()
    response = conn.get("http://www.webcal.fi/cal.php?id=50&format=json&start_year=current_year&end_year=next_year&tz=America%2FDenver")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
