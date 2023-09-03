pragma solidity >=0.4.22 <=0.8.17;

contract StringGenerator {
    bytes s;
    mapping(address => bool) added;

    function addCharacter(string memory character) public {
        // Write your code here
        require(s.length < 5);
        require(!added[msg.sender]);

        added[msg.sender] = true;

        bytes memory b = bytes(character);

        require(b.length == 1);
        s = bytes.concat(s, b);
    }

    function getString() public view returns (string memory) {
        // Write your code here
        return string(s);
    }
}
