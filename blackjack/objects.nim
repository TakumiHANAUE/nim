include typedefinition

type
    Stock = ref object of RootObj
        card: seq[Card]

type
    Member = ref object of RootObj
        hand: seq[Card]
        score: Score

type
    Player = ref object of Member

type
    Dealer = ref object of Member
        stock: Stock

