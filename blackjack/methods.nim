import random
include objects

#
method ShuffleStock(stock: Stock): bool {.base.} =
        # 昇順に山札を初期化する
        shuffle(stock.card)
        return true

#
method GetCard(stock: Stock): Card {.base.} =
        var retCard: Card
        retCard = stock.card.pop()
        # popでseqの要素がなくなったときの保護処理
        return retCard

#
method CalculateScore(member: Member): bool {.base.} =
    var sumScore: Score

    for i in 0..<member.hand.len:
        sumScore += cast[uint](member.hand[i].number)
    
    member.score = sumScore

    return true

#
method StopDrawing(player: Player): bool {.base.} =
    echo "Turn end."
    return true

#
method ReceiveCard(player: Player, card: Card): bool {.base.} =
    player.hand.add(card)
    return true

#
method DealCards(dealer: Dealer, player: Player): bool {.base.} =
    var card: Card
    card = dealer.stock.GetCard()
    
    result = player.ReceiveCard(card)

#
method ShuffleStock(dealer: Dealer): bool {.base.} =
    result = dealer.stock.ShuffleStock()

#
method TrunUpHand(dealer: Dealer): bool {.base.} =
    result = false
    
    for i in 0..<dealer.hand.len:
        if dealer.hand[i].isUp == false:
            dealer.hand[i].isUp = true
            result = true
            break

