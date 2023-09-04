pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
    // Write your code here
    address richest = address(0);
    mapping(address => uint) amounts;
    mapping(address => bool) previousRichest;
    
    function becomeRichest() external payable {
        amounts[msg.sender] += msg.value;
        if (amounts[msg.sender] > amounts[richest]) {
            richest = msg.sender;
            previousRichest[msg.sender] = true;
        }
    }

    function withdraw() external {
        // require(msg.sender != richest);
        // require(previousRichest[msg.sender]);
        if (msg.sender != richest && previousRichest[msg.sender]) {
            uint value = amounts[msg.sender];
            amounts[msg.sender] = 0;
            payable(msg.sender).call{value: value}("");
        }
    }

    function getRichest() public view returns (address) {
        return richest;
    }
}
