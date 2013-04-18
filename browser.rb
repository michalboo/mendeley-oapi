require 'watir-webdriver'

module Browser
  # Creates a browser instance, authenticates as the user (w/ username and password provided), gets verification code
  def self.login_get_verifier(username=nil, password=nil, authorize_url=nil)
    $browser = Watir::Browser.new
    #TODO Anything other than the happy path
    $browser.goto(authorize_url)
    $browser.text_field(:id => "login_email").set(username)
    $browser.text_field(:id => "login_password").set(password)
    $browser.button(:text => "Login").click
    $browser.button(:text => "Accept").click
    verifier = $browser.div(:class => "box").text
    $browser.close

    return verifier
  end
end