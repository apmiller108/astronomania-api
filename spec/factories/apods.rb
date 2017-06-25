FactoryGirl.define do
  factory :apod do
    copyright 'Gemini Obs.'
    date '2017-06-25'
    explanation <<~TEXT
      What created this gigantic hole?  The vast emission nebula N44 in our
      neighboring galaxy the Large Magellanic Cloud has a large, 250 light-year
      hole and astronomers are trying to figure out why.  One possibility is
      particle winds expelled by massive stars in the bubble's interior that
      are pushing out the glowing gas.  This answer was found to be inconsistent
      with measured wind velocities, however.  Another possibility is that the
      expanding shells of old supernovas have sculpted the unusual space cavern.
      An unexpected clue of hot X-ray emitting gas was recently been detected
      escaping the N44 superbubble.  The featured image was taken in three
      very specific colors by the huge 8-meter Gemini South Telescope on Cerro
      Pachon in Chile.    Follow APOD on: Facebook,  Google Plus,  Instagram, or
      Twitter
    TEXT
    hdurl 'https://apod.nasa.gov/apod/image/1706/n44_gemini_4059.jpg'
    media_type 'image'
    service_version 'v1'
    title 'The N44 Superbubble'
    url 'https://apod.nasa.gov/apod/image/1706/n44_gemini_960.jpg'
  end
end
