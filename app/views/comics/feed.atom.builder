atom_feed :language => 'en-US' do |feed|
  feed.title "another webcomic"
  feed.updated @comics.first.date
  feed.subtitle "Twice a week I'll have new comics on a variety of topics just for you."

  @comics.each do |comic|
    feed.entry( comic ) do |entry|
      entry.url "#{request.protocol}#{request.host_with_port}/#{comic.slug}"
      entry.date comic.date
      entry.title comic.title
      entry.icon comic.photo.url :display

      #put the image into the blurb...
      blurb = "<img src=\"#{ comic.photo.url :display }\" /> " +  comic.blurb
      entry.content blurb.html_safe, :type=>'html'
    end
  end
end
