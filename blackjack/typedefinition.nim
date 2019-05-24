type Score* = range[0..30]
    ## Score of hand

type Suit* = enum
    ## suits of card
    Spades, Hearts, Clubs, Diamonds

type CardNumber* = enum
    ## card number; 1 to King
    ACE = 1, TWO, THREE, FOUR, FIVE,
    SIX, SEVEN, EIGHT, NINE, TEN,
    JACK, QUEEN, KING

type Card* = tuple
    ## specs of a card.
    ##
    ## suit: suit of a card
    ##
    ## number: number of a card
    ##
    ## isUp: if a card is face up or not
    suit: Suit
    number: CardNumber
    isUp: bool
