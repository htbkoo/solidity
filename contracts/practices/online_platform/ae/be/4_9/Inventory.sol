pragma solidity >=0.4.22 <=0.8.17;

contract Inventory {
    // Write your code here
    mapping(uint => int) public quantities;

    function addItem(uint256 itemId, uint256 quantity) public {
        // if (!itemId in quantities) {
        //     quantities[itemId] = 0;
        // }
        quantities[itemId] += int256(quantity);
    }

    function getQuantity(uint256 itemId) public view returns (int256) {
        // if (!itemId in quantities) {
        if (quantities[itemId] == 0) {
            return -1;
        }
        return quantities[itemId];
    }
}
