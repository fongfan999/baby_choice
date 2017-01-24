require 'xml-sitemap'

namespace :sitemap do
  desc "Refresh site data"

  task refresh: :environment do
    host = 'luachontotchobe.com'
    map = XmlSitemap::Map.new(host)

    Spina::Category.live.each do |category|
      map.add "/categories/#{category.slug}", period: :daily, priority: 0.9
    end
    Spina::Article.newest_first.limit(3).each do |article|
      map.add "/articles/#{article.slug}", period: :daily, priority: 0.8
    end

    map.render_to Rails.root.join('public', 'sitemap.xml')
  end
end
