import typedefinition
import random
import strutils
from times import now

type
    Stock* = ref object of RootObj
        card*: seq[Card]

method Reset(stock: Stock): void {.base.} =
    ## reset a stock in ascending order
    # reset stock cards
    stock.card = @[]
    # gather cards as a stock
    var aCard: Card = (suit: Spades, number: ACE, isUp: false)
    for suit in Spades..Diamonds:
        for retNum in ACE..KING:
            aCard = (suit, retNum, false)
            stock.card.add(aCard)

method ShuffleStock(stock: Stock): bool {.base.} =
    ## shuffle a stock in rondom order
    var now = now()
    randomize(now.nanosecond)
    shuffle(stock.card)
    return true

method GetCard(stock: Stock): Card {.base.} =
    ## get a card from a stock
    var retCard: Card
    retCard = stock.card.pop()
    # TODO: popでseqの要素がなくなったときの保護処理
    return retCard

type
    Member* = ref object of RootObj
        name*: string
        hand*: seq[Card]
        score*: Score
        isBurst*: bool

#
method Reset*(member: Member): void {.base.} =
    ## reset member's hand
    member.hand = @[]
    member.score = 0

#
method CalculateScore*(member: Member): bool {.base.} =
    ## calculate member's hand score
    var sumScore: Score

    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            var retNum = cast[uint](member.hand[i].number)
            if retNum > cast[uint](TEN):
                sumScore += 10
            else:
                sumScore += retNum
    
    member.score = sumScore

    return true

const SCORE_MAX = 21
method IsBurst*(member: Member): void {.base.} =
    ## check if member's hand gets burst or not
    if member.score > SCORE_MAX:
        member.isBurst = true

const ALIGN_NUM = 2

proc SuitToString(suit: Suit): string =
    ## convert a suit to string to print out
    var retSuit: string
    case suit
    of Spades:
        retSuit = align("♠", ALIGN_NUM)
    of Hearts:
        retSuit = align("♥", ALIGN_NUM)
    of Clubs:
        retSuit = align("♣", ALIGN_NUM)
    of Diamonds:
        retSuit = align("♦", ALIGN_NUM)
    
    return retSuit

proc NumberToString(number: CardNumber): string =
    ## convert number to string to print out
    var retNum: string
    case number
    of TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN:
        retNum = intToStr(cast[int](number))
    of ACE:
        retNum = "A"
    of JACK:
        retNum = "J"
    of QUEEN:
        retNum = "Q"
    of KING:
        retNum = "K"
    
    return retNum


method PrintHands*(member: Member): void {.base.} =
    ## print out member's hand
    echo ""
    echo "**** ", member.name, " ****"
    echo "Score: ", member.score
    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            var suit: string = SuitToString(member.hand[i].suit)
            write(stdout, suit, " ")
        else:
            write(stdout, align("X", ALIGN_NUM))
    echo ""
    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            var retNum: string = NumberToString(member.hand[i].number)
            write(stdout, retNum, " ")
        else:
            write(stdout, align("X", ALIGN_NUM))
    echo ""

type
    Player* = ref object of Member

method ReceiveCard(player: Player, card: var Card): bool {.base.} =
    ## Player receive a card, and add it to player's hand.
    card.isUp = true
    player.hand.add(card)
    return true

type
    Dealer* = ref object of Member
        stock*: Stock

method GetStock*(dealer: Dealer, stock: Stock): void {.base.} =
    ## Dealer gets a stock.
    stock.Reset()
    dealer.stock = stock

method DealCard*(dealer: Dealer, player: Player): bool {.base.} =
    ## Dealer deal a card to a player.
    var card: Card
    card = dealer.stock.GetCard()
    result = player.ReceiveCard(card)

method GetCard*(dealer: Dealer): bool {.base.} =
    ## Dealer gets a card, and add it to dealer's hand.
    var card: Card
    card = dealer.stock.GetCard()
    dealer.hand.add(card)
    #result = dealer.CalculateScore()
    return result

method ShuffleStock*(dealer: Dealer): bool {.base.} =
    ## Dealer shuffle dealer's stock.
    result = dealer.stock.ShuffleStock()

method TurnUpHand*(dealer: Dealer): bool {.base.} =
    ## Dealer turn dealer's hand up.
    result = false
    
    for i in 0..<dealer.hand.len:
        if dealer.hand[i].isUp == false:
            dealer.hand[i].isUp = true
            result = true
            break
