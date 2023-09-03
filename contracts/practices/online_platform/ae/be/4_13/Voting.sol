pragma solidity >=0.4.22 <=0.8.17;

contract Voting {
    // Write your code here
    mapping(uint8 => uint) votes;
    mapping(address => bool) voted;
    uint8 best = 1;

    function getVotes(uint8 number) public view returns (uint) {
        require (1 <= number && number <= 5);
        return votes[number];
    }

    function vote(uint8 number) public {
        require (1 <= number && number <= 5);
        require (!voted[msg.sender]);

        voted[msg.sender] = true;
        votes[number]++;
        if (votes[number] >= votes[best]) {
            best = number;
        }
    }

    function getCurrentWinner() public view returns (uint8) {
        return best;
    }
}
