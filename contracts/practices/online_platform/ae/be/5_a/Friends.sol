pragma solidity >=0.4.22 <=0.8.17;

contract Friends {
    mapping(address => mapping(address => bool)) hasSentFriendRequest;
    mapping(address => address[]) friendRequests;

    mapping(address => mapping(address => bool)) areFriends;
    mapping(address => address[]) friends;

    // Write your code here
    function getFriendRequests() public view returns (address[] memory) {
        return friendRequests[msg.sender];
    }

    function getNumberOfFriends() public view returns (uint) {
        return getFriends().length;
    }

    function getFriends() public view returns (address[] memory) {
        return friends[msg.sender];
    }

    function sendFriendRequest(address friend) public {
        require(msg.sender != friend);
        require(!hasSentFriendRequest[msg.sender][friend]);
        require(!hasSentFriendRequest[friend][msg.sender]);
        require(!areFriends[msg.sender][friend]);
        hasSentFriendRequest[msg.sender][friend] = true;
        friendRequests[friend].push(msg.sender);
    }

    function findFriendRequestIndex(address friend) private view returns (int) {
        for (uint i = 0; i < friendRequests[msg.sender].length; ++i) {
            if (friendRequests[msg.sender][i] == friend) {
                return int(i);
            }
        }
        return -1;
    }

    function acceptFriendRequest(address friend) public {
        require(hasSentFriendRequest[friend][msg.sender]);
        require(!areFriends[friend][msg.sender]);

        areFriends[friend][msg.sender] = true;
        friends[friend].push(msg.sender);
        areFriends[msg.sender][friend] = true;
        friends[msg.sender].push(friend);

        int idx = findFriendRequestIndex(friend);
        if (idx > 0) {
            friendRequests[msg.sender][uint(idx)] = friendRequests[msg.sender][friendRequests[msg.sender].length - 1];
            friendRequests[msg.sender].pop();
        }
    }
}
