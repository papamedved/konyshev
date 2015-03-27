module UrlImageHelper
  def hello
    "hello"
  end

  def UrlImageTumb url
    File.dirname(url) + '/' + File.basename(url, File.extname(url)) + '_tumb' + File.extname(url)
  end
end
