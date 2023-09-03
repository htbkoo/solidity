pragma solidity >=0.4.22 <=0.8.17;

contract OnlyOwner {
    // Write your code here
    uint8 private num = 0;

    function add(uint8 number) public {
        num += number;
    }

    function subtract(uint8 number) public {
        num -= number;
    }

    function get() public view returns (uint8) {
        return num;
    }
}
