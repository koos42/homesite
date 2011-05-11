atom_feed :language => 'en-US' do |feed|
  feed.title "another webcomic"
  feed.updated @comics.first.date

  @comics.each do |comic|
    next if comic.publish == false || comic.date > Time.now.to_date

    feed.entry( comic ) do |entry|
      entry.url comic_url(comic)
      entry.date comic.date
      entry.title comic.title
      entry.content comic.blurb
      entry.icon comic.photo.url(:full)
    end
  end
end
