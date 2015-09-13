module InspirationalQuote
  QUOTES = YAML.load(File.read(Rails.root.join("public/inspirational_quotes.yml")))

  def self.random
    QUOTES.shuffle.first  
  end
end
