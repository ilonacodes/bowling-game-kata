class Game

  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def roll(pins)
    rolls.push(pins)
  end

  def score
    sum = 0
    frame_index = 0
    frame = 0
    rolls.each_with_index do |roll, index|
      frame += 1 if frame_index == 0
      return sum if frame > 10

      if roll == 10 && frame_index == 0
        sum += rolls[index + 1] + rolls[index + 2]
      elsif rolls[index - 1] + rolls[index] == 10 && frame_index == 1
        sum += rolls[index + 1]
        frame_index = 0
      else
        frame_index = 1 - frame_index
      end
      sum += roll
    end
    sum
  end

  # def score
  #   sum = 0
  #   frame_start = 0
  #   10.times do
  #     frame = Frame.create(rolls, frame_start)
  #     sum += frame.score + frame.bonus
  #     frame_start += frame.size
  #   end
  #
  #   sum
  # end
end

class Frame
  attr_reader :rolls, :start
  def initialize(rolls, start)
    @rolls = rolls
    @start = start
  end

  def self.create(rolls, start)
    if rolls[start] == 10
      StrikeFrame.new(rolls, start)
    elsif rolls[start] + rolls[start + 1] == 10
      SpareFrame.new(rolls, start)
    else
      NormalFrame.new(rolls, start)
    end
  end
end

class NormalFrame < Frame
  def bonus
    0
  end

  def score
    rolls[start] + rolls[start + 1]
  end

  def size
    2
  end
end

class SpareFrame < Frame
  def bonus
    rolls[start + 2]
  end

  def score
    10
  end

  def size
    2
  end
end

class StrikeFrame < Frame
  def bonus
    rolls[start + 1] + rolls[start + 2]
  end

  def score
    10
  end

  def size
    1
  end
end