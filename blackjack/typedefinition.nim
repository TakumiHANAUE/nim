type
    Score = range[0..30]

type
    Suit = enum
        Spades, Hearts, Clubs, Diamonds

type
    CardNumber = enum
        ACE = 1, TWO, THREE, FOUR, FIVE,
        SIX, SEVEN, EIGHT, NINE, TEN,
        JACK, QUEEN, KING

type
    Card = tuple
        suit: Suit
        number: CardNumber
        isUp: bool
