import methods

proc Initialize(dealer: var Dealer, player: var Player, stock: var Stock): bool =
    echo ">>> Initializing"
    
    dealer.Reset()
    dealer.GetStock(stock)
    result = dealer.ShuffleStock()
    player.Reset()
    
    return result

proc DealCards(dealer: var Dealer, player: var Player): bool =
    echo ">>> Deal Cards"

    for i in 0..1:
        result = dealer.DealCard(player)
        result = dealer.GetCard()
    
    dealer.hand[0].isUp = true
    result = dealer.CalculateScore()
    result = player.CalculateScore()
    
    dealer.PrintHands()
    player.PrintHands()
    echo ""
    return result

proc DrawCard_Player(dealer: Dealer, player: var Player): bool =
    echo ">>> Draw Card (Player)"
    var ret: string
    while ((ret != "n") and (player.isBurst == false)):
        echo "> Do you draw an additinal card ? [y/n]"
        ret = stdin.readLine
        if ret == "y":
            result = dealer.DealCard(player)
            result = player.CalculateScore()
            player.PrintHands()
        elif ret == "n":
            echo "> Your turn finished"
        else:
            echo "> Please put y or n"

        result = player.CalculateScore()
        player.IsBurst()

proc DrawCard_Dealer(dealer: var Dealer): bool =
    var ret: string
    echo ">>> Draw Card (Dealer)"
    echo "> Dealer turn a card up"
    result = dealer.TurnUpHand()
    result = dealer.CalculateScore()
    dealer.PrintHands()
    while dealer.score < 17:
        echo "> Dealer draws a card [Press ENTER]"
        ret = stdin.readLine
        result = dealer.GetCard()
        result = dealer.TurnUpHand()
        result = dealer.CalculateScore()
        dealer.IsBurst()
        dealer.PrintHands()
    
    return result

proc Judge(dealer: Dealer, player: Player): bool =
    echo ">>> Judgememt"
    dealer.PrintHands()
    player.PrintHands()
    if player.isBurst == true:
        echo "> Burst! " & player.name & " LOSE."
    elif dealer.isBurst == true:
        echo "> " & dealer.name & " Burst. " & player.name & " WIN !"
    else:
        if player.score > dealer.score:
            echo "> " & player.name & " WIN !"
        elif player.score < dealer.score:
            echo "> " & player.name & " LOSE !"
        else:
            echo "> DRAW"
    
    return true