class MondoService
  def initialize(token, account_id = nil)
    @token = token
    @account_id = account_id
    @client = Mondo::Client.new(token: @token, account_id: @account_id)
  end

  def transactions(*options)
    @client.transactions(*options).reverse
  end

  def transaction(id, options = {})
    options[:account_id] = @account_id
    @client.transaction(id, options)
  end

  def cards(*options)
    @client.cards(*options)
  end

  def accounts(*options)
    @client.accounts(*options)
  end

  def balance
    @client.balance
  end

  def self.client(site: :auth)
    @_client ||= {}
    @_client[site] ||= OAuth2::Client.new(
      ENV['MONDO_CLIENT_ID'],
      ENV['MONDO_CLIENT_SECRET'],
      site: site == :api ? ENV['MONDO_API_URL'] : ENV['MONDO_AUTH_URL'],
      authorize_url: '/',
      token_url: '/oauth2/token'
    )
  end

  def self.authorize_url(redirect_uri: nil)
    self.client.auth_code.authorize_url(redirect_uri: redirect_uri)
  rescue
    nil
  end

  def self.token_from_code(code, redirect_uri: nil)
    request = self.client(site: :api).auth_code.get_token(code, redirect_uri: redirect_uri)
    request.token
  rescue
    nil
  end

end
