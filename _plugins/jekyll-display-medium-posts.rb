require 'feedjira'
require 'jekyll'
module Jekyll
  class JekyllDisplayMediumPosts < Generator
    safe true
    priority :high
def generate(site)
      jekyll_coll = Jekyll::Collection.new(site, 'medium_posts')
      site.collections['medium_posts'] = jekyll_coll
Feedjira::Feed.fetch_and_parse("https://medium.com/feed/@rizalex").entries.each do |post|
        p "Title: #{post.title}, published on Medium #{post.url} #{post}"
        title = post[:title]
        content = post[:content]
        guid = post[:url]
        path = "./medium_posts/" + title + ".md"
        path = site.in_source_dir(path)
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        doc.data['title'] = title;
        doc.data['feed_content'] = content;
        doc.data['medium_link'] = post.url;
        jekyll_coll.docs << doc
      end
    end
  end
end
