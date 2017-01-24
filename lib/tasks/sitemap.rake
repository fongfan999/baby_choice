require 'xml-sitemap'

namespace :sitemap do
  desc "Refresh site data"

  task refresh: :environment do
    host = 'luachontotchobe.com'
    map = XmlSitemap::Map.new(host)

    Spina::Article.newest_first.each do |article|
      map.add "/articles/#{article.slug}", updated: article.updated_at,
        period: :daily, priority: 0.8
    end

    map.render_to Rails.root.join('public', 'sitemap.xml').to_s
  end
end