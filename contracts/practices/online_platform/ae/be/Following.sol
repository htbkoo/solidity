pragma solidity >=0.4.22 <=0.8.18;

contract Following {
    // Write your code here
    mapping(address => address[]) f;

    function follow(address toFollow) public {
        require(msg.sender != toFollow);
        require(f[msg.sender].length < 3);

        f[msg.sender].push(toFollow);
    }

    function getFollowing(address addr) public view returns (address[] memory) {
        return f[addr];
    }

    function clearFollowing() public {
        delete f[msg.sender];
    }
}
