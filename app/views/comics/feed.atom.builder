atom_feed :language => 'en-US' do |feed|
  feed.title "another webcomic"
  feed.updated @comics.first.date

  @comics.each do |comic|
    feed.entry( comic ) do |entry|
      entry.url comic_url(comic)
      entry.date comic.date
      entry.title comic.title
      entry.content comic.blurb.html_safe, :type=>'html'
      entry.icon comic.photo.url(:full)
      entry.icon comic.original_photo.url(:full) if comic.has_original?
    end
  end
end
