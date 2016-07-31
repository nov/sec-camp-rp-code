# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'production'
  Client.create(
    identifier: '1735ae91cb46163c0cb9cf8044888962',
    secret: '25b28b72d1c067e156de71e8b2f33b59d671c22553750483ccf9ece1828adf9f',
    redirect_uri: 'https://sec-camp-rp-code.herokuapp.com/callback',
    authorization_endpoint: 'https://sec-camp-idp.herokuapp.com/authorizations/new',
    token_endpoint: 'https://sec-camp-idp.herokuapp.com/tokens',
    userinfo_endpoint: 'https://sec-camp-idp.herokuapp.com/user_info'
  )
when 'development'
  Client.create(
    identifier: '8d6c384015481a2e1e6151bcd283a64d',
    secret: 'ad1d3c5c4948fb0b06952c5075e53ed46ba86d93c1d501633cc4fd24a99c229b',
    redirect_uri: 'http://sec-rp-code.dev/callback',
    authorization_endpoint: 'http://sec-idp.dev/authorizations/new',
    token_endpoint: 'http://sec-idp.dev/tokens',
    userinfo_endpoint: 'http://sec-idp.dev/user_info'
  )
end