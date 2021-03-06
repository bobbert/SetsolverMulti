class Threecardset < ActiveRecord::Base
  # RWP: originally named "set"; changed to "threecardset" to avoid namespace clash
  
  has_many :cards
  belongs_to :player

  validate :must_have_three_cards_that_belong_to_same_deck


  # validation conditions: 3-card sets must contain three cards, and all cards 
  # must be part of the same deck.
  def must_have_three_cards_that_belong_to_same_deck
    errors.add_to_base("Set ##{self.id} does not have three cards!") unless cards.length == 3
    unique_decks = cards.map {|card| card.deck }.compact.uniq
    if unique_decks.length > 1
      errors.add_to_base("Set ##{self.id} has cards from different decks!")
    elsif unique_decks.length == 0
      errors.add_to_base("Set ##{self.id} has cards that don't belong to a deck!")      
    end
  end

  # array of cardfaces corresponding to cards
  def cardfaces
    cards.map {|card| card.cardface }
  end

  # returns deck if cards are present, or nil otherwise.
  # All cards must belong to the same deck; see validation above
  def deck
    cards[0].deck if cards.length > 0
  end

  # returns game if deck is present
  def game
    deck.game if deck
  end

  # returns Score object (game-player association)
  def score
    Score.find_by_player_id_and_game_id( player.id, game.id )
  end
  
  # returns list of common attributes within set
  def common_attributes
    cf = cardfaces
    Cardface::ATTR.inject([]) do |common_arr, attrib|
      common_arr << attrib if deck && game.num_different_attr( attrib, cf ) == 1
      common_arr
    end
  end

  # set-equality operator - returns true if the same three cards
  def ===(other)
    return false unless other.is_a? Threecardset
    return (self.cardfaces.sort == other.cardfaces.sort)
  end

  # set-sorting operator - sort by time found, most recent first
  def <=>(other)
    cmp = (other.created_at <=> self.created_at)
    cmp = (self.id <=> other.id) if cmp == 0
    cmp
  end

end
