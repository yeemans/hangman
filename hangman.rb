require 'fileutils'
class Game
  @@chances = 5
  def self.GetWord()
    @@dictionary = File.readlines('dict.txt')
    @@word = @@dictionary.sample
    @@word = @@word.gsub("\n", "")
    #array of underscores, representing characters
    @@letters = []
    #p @@word
    for i in 0...@@word.length
        @@letters.append("_")
    end
  end
  
  def self.GetGuess()
    puts("Guess a letter")
    print @@letters
    @@guess = gets
    if @@guess == "save\n"
      Save()
    elsif @@guess == "load\n"
      Load()
    else
      @@guess = @@guess.gsub("\n", "")
      for j in 0...@@word.length()
        if @@guess == @@word[j]
          @@letters[j] = @@guess
        end
      end
      print @@letters
      KeepScore()
      if @@letters.join("") != @@word
        GetGuess()
      end
    end
  end

  def self.KeepScore()
    if @@word.include?(@@guess) == false || @@guess.length > 2
      @@chances -= 1
      print "Chances: #{@@chances}" 
    end
    if @@chances == 0
      puts"You lost"
      puts @@word
      exit!
    end
  end

  def self.Save()
    save_file = File.open('save.txt', "w+")
    save_file.write(@@word)
    save_file.write("\n")
    save_file.write(@@letters)
    save_file.write("\n")
    save_file.write(@@chances)
    save_file.close
    # testing 
  end
  
  def self.Load()
    @@line = File.readlines("save.txt")
    @@word = @@line[0].gsub("\n", "")
    @@letters = eval(@@line[1])
    @@chances = @@line[2].to_i()
    #print @@word
    print @@letters
    print @@chances
    print @@letters.class
    GetGuess()
  end
end

Game.GetWord()
Game.GetGuess()
