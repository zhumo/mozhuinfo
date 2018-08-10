puts 'Sample Post...'
Blog.find_or_create_by!(
  title: 'This is my blog',
  summary: 'my thoughts',
  body: %q(The flock of geese flew overhead in a “V” formation – not in an old-fashioned-looking Times New Roman kind of a “V”, branched out slightly at the two opposite arms at the top of the “V”, nor in a more modern-looking, straight and crisp, linear Arial sort of “V” (although since they were flying, Arial might have been appropriate), but in a slightly asymmetric, tilting off-to-one-side sort of italicized Courier New-like “V” – and LaFonte knew that he was just the type of man to know the difference.),
  slug: 'sample_blog',
)

puts 'Sample User...'
mom = User.find_or_create_by!(
  name: "Mom",
  phone_number: "1234567890",
)

puts 'Sample Ping...'
mom.pings.find_or_create_by!(
  algorithm: Ping::YEARLY_ALGORITHM,
  message: "Happy Birthday!",
)
