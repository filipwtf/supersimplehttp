require "test_helper"

class SupersimplehttpTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Supersimplehttp::VERSION
  end

  def test_query_parsing
    path = 'pog?name=filip&age=19'
    query = path.split('?')[1]

    params = query.split('&')
    queries = {}
    params.each do |parameter|
      return queries if parameter == ""
      param, value = parameter.split('=')
      param = param.gsub(":", "").downcase.to_sym
      queries[param] = value
    end
    assert queries == {:name=>"filip", :age=>"19"}
  end

  def test_path_normalize
    some_path = '../../../../../some dir/some file'
    # some_path.gsub!(/\.+/, ".")
    replacements = [['%2e', '.'], ['%2f', '/'], ['%5c', ''], ['%255c', ''], ['.',''], [':', ':.'], ['=/', '']]
    replacements.each {|replacement| some_path.gsub!(replacement[0], replacement[1])}

    assert some_path == '/////some dir/some file'
  end


 
  def test_body_parser
    http_request = "POST /pog HTTP/1.1\r\n
    Content-Type: text/plain\r\n
    User-Agent: PostmanRuntime/7.26.3\r\n
    Accept: */*\r\n
    Cache-Control: no-cache\r\n
    Postman-Token: c898ab42-8c40-45a6-bb36-bff4a01585f3\r\n
    Host: localhost:5000\r\n
    Accept-Encoding: gzip, deflate, br\r\n
    Connection: keep-alive\r\n
    Content-Length: 8\r\n
    \r\n
    wewewewe\r\n"
      
    assert true
  end
end

