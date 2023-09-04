pragma solidity >=0.4.22 <=0.8.17;

contract GreedyBanker {
    address owner;

    mapping(address => uint) deposits;
    mapping(address => bool) hasUsedFreeDeposit;
    uint feesCollected;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        // Write your code here
        uint fee = 0;
        if (hasUsedFreeDeposit[msg.sender]) {
            fee = 1000;
            require(msg.value >= fee);
        }
        hasUsedFreeDeposit[msg.sender] = true;
        deposits[msg.sender] += msg.value - fee;
        feesCollected += fee;
    }

    fallback() external payable {
        // Write your code here
        feesCollected += msg.value;
    }

    function withdraw(uint256 amount) external {
        // Write your code here
        require(amount <= deposits[msg.sender]);
        deposits[msg.sender] -= amount;
        payable(msg.sender).call{value: amount}("");
    }

    function collectFees() external {
        // Write your code here
        require(msg.sender == owner);
        uint value = feesCollected;
        feesCollected = 0;
        payable(owner).call{value: value}("");
    }

    function getBalance() public view returns (uint256) {
        // Write your code here
        return deposits[msg.sender];
    }
}
