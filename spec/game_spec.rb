require_relative 'spec_helper'
require_relative './../lib/game'

RSpec.describe 'Game' do
  let(:game) { Game.new }

  it 'returns total score 0 for gutter game' do
    20.times { game.roll(0) }

    expect(game.score).to eq(0)
  end

  it 'returns total score 7' do

    8.times { game.roll(0) }
    game.roll(4)
    game.roll(1)
    game.roll(2)

    10.times { game.roll(0) }

    expect(game.score).to eq(7)

  end

  it 'returns score with strike bonus' do

    4.times { game.roll(0) }

    game.roll(10)
    game.roll(2)
    game.roll(5)

    12.times { game.roll(0) }

    expect(game.score).to eq(24)
  end

  it 'returns score with spare bonus for 10' do

    10.times { game.roll(0) }

    game.roll(0)
    game.roll(10)

    game.roll(4)
    game.roll(3)

    6.times { game.roll(0) }

    expect(game.score).to eq(21)

  end

  it 'returns score without spare bonus when rolls out of frame' do
    10.times { game.roll(0) }

    game.roll(0)
    game.roll(6)
    game.roll(4)
    game.roll(5)

    6.times { game.roll(0) }

    expect(game.score).to eq(15)
  end

  it 'returns score without spare bonus when rolls out of frame with one strike before' do
    8.times { game.roll(0) }

    game.roll(10)
    game.roll(0)
    game.roll(6)
    game.roll(4)
    game.roll(5)

    6.times { game.roll(0) }

    expect(game.score).to eq(31)
  end

  it 'perfect game' do
    12.times { game.roll(10) }

    expect(game.score).to eq(300)
  end

  it 'almost perfect game' do
    9.times { game.roll(10) }

    game.roll(4)
    game.roll(6)
    game.roll(9)

    expect(game.score).to eq(273)
  end

end