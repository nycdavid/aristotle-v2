class Calendar
  def initialize(date)
    @date = date
  end

  def haml
    Haml::Engine.new "%h1 Etcetera"
  end
end
