pragma solidity >=0.4.22 <=0.8.17;

contract Balances {
    // Write your code here
    mapping(address => uint) amounts;

    function getAmountSent(address addr) external view returns (uint) {
        return amounts[addr];
    }

    receive() external payable {
        amounts[msg.sender] += msg.value;
    }

    fallback() external payable {
        amounts[msg.sender] += msg.value;
    }
}
