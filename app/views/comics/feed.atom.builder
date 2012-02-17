atom_feed :language => 'en-US' do |feed|
  feed.title "another webcomic"
  feed.updated @comics.first.date
  feed.subtitle "I hope you Google reader nerds are happy (Alex, Lauren, & Lee)"

  @comics.each do |comic|
    feed.entry( comic ) do |entry|
      entry.url comic_url(comic)
      entry.date comic.date
      entry.title comic.title
      entry.icon comic.photo.url :display

      #put the image into the blurb...
      blurb = "<img src=\"#{ comic.photo.url :display }\" /> " +  comic.blurb
      entry.content blurb.html_safe, :type=>'html'
    end
  end
end
