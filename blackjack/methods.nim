import typedefinition
import random
from times import now

############################

type
    Stock* = ref object of RootObj
        card*: seq[Card]

#
method Reset(stock: Stock): void {.base.} =
    # reset stock cards
    stock.card = @[]
    # gather cards as a stock
    var aCard: Card = (suit: Spades, number: ACE, isUp: false)
    for suit in Spades..Diamonds:
        for num in ACE..KING:
            aCard = (suit, num, false)
            stock.card.add(aCard)

#
method ShuffleStock(stock: Stock): bool {.base.} =
    var now = now()
    randomize(now.nanosecond)
    shuffle(stock.card)
    return true

#
method GetCard(stock: Stock): Card {.base.} =
    var retCard: Card
    retCard = stock.card.pop()
    # TODO: popでseqの要素がなくなったときの保護処理
    return retCard

############################

type
    Member* = ref object of RootObj
        name*: string
        hand*: seq[Card]
        score*: Score
        isBurst*: bool

#
method Reset*(member: Member): void {.base.} =
    member.hand = @[]
    member.score = 0

#
method CalculateScore*(member: Member): bool {.base.} =
    var sumScore: Score

    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            var num = cast[uint](member.hand[i].number)
            if num > cast[uint](TEN):
                sumScore += 10
            else:
                sumScore += num
    
    member.score = sumScore

    return true

method IsBurst*(member: Member): void {.base.} =
    if member.score > 21: # SCORE_MAX
        member.isBurst = true

#
method PrintHands*(member: Member): void {.base.} =
    echo ""
    echo "**** ", member.name, " ****"
    echo "Score: ", member.score
    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            write(stdout, member.hand[i].suit, " ")
        else:
            write(stdout, "XXX ")
    echo ""
    for i in 0..<member.hand.len:
        if member.hand[i].isUp == true:
            write(stdout, member.hand[i].number, " ")
        else:
            write(stdout, "XXX ")
    echo ""

###########################

type
    Player* = ref object of Member

#
method StopDrawing(player: Player): bool {.base.} =
    echo "Turn end."
    return true

#
method ReceiveCard(player: Player, card: var Card): bool {.base.} =
    card.isUp = true
    player.hand.add(card)
    return true

#############################

type
    Dealer* = ref object of Member
        stock*: Stock

#
method GetStock*(dealer: Dealer, stock: Stock): void {.base.} =
    stock.Reset()
    dealer.stock = stock

#
method DealCard*(dealer: Dealer, player: Player): bool {.base.} =
    var card: Card
    card = dealer.stock.GetCard()
    result = player.ReceiveCard(card)

method GetCard*(dealer: Dealer): bool {.base.} =
    var card: Card
    card = dealer.stock.GetCard()
    dealer.hand.add(card)
    #result = dealer.CalculateScore()
    return result

#
method ShuffleStock*(dealer: Dealer): bool {.base.} =
    result = dealer.stock.ShuffleStock()

#
method TurnUpHand*(dealer: Dealer): bool {.base.} =
    result = false
    
    for i in 0..<dealer.hand.len:
        if dealer.hand[i].isUp == false:
            dealer.hand[i].isUp = true
            result = true
            break

################################