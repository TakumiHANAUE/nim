import typedefinition
import methods
include procedure

import times

echo "Welcome to Nim Blackjack !"

var processRet: bool

# Create instances
var stock: Stock = Stock(card: @[])
var dealer: Dealer = Dealer(name: "Dealer", hand: @[], score: 0, isBurst: false, stock: stock)
var player0: Player = Player(name: "Player01", hand: @[], score: 0, isBurst: false)

# Initialize
processRet = Initialize(dealer, player0, stock)

# Deal Cards
processRet = DealCards(dealer, player0)

# Draw Card (Player)
processRet = DrawCard_Player(dealer, player0)

# Draw Card (Dealer)
if player0.isBurst == false:
    processRet = DrawCard_Dealer(dealer)

# Judge
processRet = Judge(dealer, player0)
