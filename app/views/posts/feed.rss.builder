xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "BlogAuth - Feed de Posts"
    xml.description "Últimas postagens do blog"
    xml.link root_url
    xml.language "pt-BR"
    
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.content.to_plain_text.truncate(200)
        xml.pubDate post.created_at.rfc822
        xml.link post_url(post)
        xml.guid post_url(post)
        xml.author begin
                post.user.email
              rescue ActiveRecord::Encryption::Errors::Decryption
                "[email protegido]"
              end
      end
    end
  end
end