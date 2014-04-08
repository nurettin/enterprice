class Wtf
  def omg
    lol
  end

  def lol
    puts "Wtf"
  end
end

class Omg< Wtf
  def lol
    puts "Omg"
  end
end

omg= Omg.new
omg.omg

