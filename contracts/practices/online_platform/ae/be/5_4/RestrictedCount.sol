pragma solidity >=0.4.22 <=0.8.17;

contract RestrictedCount {
    // Write your code here
    address owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier lessThanMax(int value) {
        require(count + value <= 100);
        _;
    }

    modifier greaterThanMin(int value) {
        require(count + value >= -100);
        _;
    }

    int count = 0;

    function getCount() public onlyOwner view returns (int) {
        return count;
    }

    function add(int value) public onlyOwner lessThanMax(value) greaterThanMin(value) {
        count += value;
    }

    function subtract(int value) public onlyOwner lessThanMax(value) greaterThanMin(value) {
        count -= value;
    }
}
