module ComicsHelper
  def comic_url(comic)
    return "#{request.protocol}#{request.host}#{show_by_slug_path(comic.slug)}"
  end
end
