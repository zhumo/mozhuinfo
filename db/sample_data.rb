Writer.create(
  display_name: "Admin",
  full_name: "Admin I. Strator",
  password: 'password',
  password_confirmation: 'password'
)

Blog.create(
  title: 'This is my blog',
  body: %q(The flock of geese flew overhead in a “V” formation – not in an old-fashioned-looking Times New Roman kind of a “V”, branched out slightly at the two opposite arms at the top of the “V”, nor in a more modern-looking, straight and crisp, linear Arial sort of “V” (although since they were flying, Arial might have been appropriate), but in a slightly asymmetric, tilting off-to-one-side sort of italicized Courier New-like “V” – and LaFonte knew that he was just the type of man to know the difference.)
)
