# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.luachontotchobe.com/"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
  fog_provider: 'AWS',
  aws_access_key_id: ENV["S3_KEY"],
  aws_secret_access_key: ENV["S3_SECRET"],
  fog_directory: ENV["S3_BUCKET"],
  fog_region: ENV["S3_REGION"]
)
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "http://s3-website-#{ENV['S3_REGION']}.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  Spina::Category.live.find_each do |category|
    add "/categories/#{category.slug}", changefreq: :daily, priority: 0.9
  end

  Spina::Article.newest_first.find_each do |article|
    add article.materialized_path, changefreq: :daily, priority: 0.8
  end
end
