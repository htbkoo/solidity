pragma solidity >=0.4.22 <=0.8.17;

contract TimedAuction {
    // Declare your event(s) here
    event Bid(address indexed sender, uint256 amount, uint256 timestamp);

    address owner;
    uint256 startTime;

    uint currentHighestBidAmount;
    address currentHighestBidder;
    mapping(address=>uint) previousBids;

    constructor() {
        owner = msg.sender;
        // reference:
        // 1. https://ethereum.stackexchange.com/a/40930
        // 2. https://ethereum.stackexchange.com/a/9876
        startTime = block.timestamp;
    }

    function isAuctionOver() private view returns (bool) {
        return block.timestamp - startTime >= 5 minutes;
    }

    function bid() external payable {
        // Write your code here
        require(!isAuctionOver());
        uint amount = msg.value;
        require(amount > currentHighestBidAmount);

        previousBids[currentHighestBidder] += currentHighestBidAmount;
        currentHighestBidAmount = amount;
        currentHighestBidder = msg.sender;

        emit Bid(currentHighestBidder, currentHighestBidAmount, block.timestamp);
    }

    function withdraw() public {
        // Write your code here
        uint value = previousBids[msg.sender];
        previousBids[msg.sender] = 0;
        (bool result, ) = payable(msg.sender).call{value: value}("");
        require(result);
    }

    function claim() public {
        // Write your code here
        require(owner == msg.sender);
        require(isAuctionOver());
        require(address(this).balance == currentHighestBidAmount);
        selfdestruct(payable(owner));
    }

    function getHighestBidder() public view returns (address) {
        // Write your code here
        return currentHighestBidder;
    }
}
