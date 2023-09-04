pragma solidity >=0.4.22 <=0.8.17;

contract EtherElection {
    mapping(address=>bool) isCandidate;
    mapping(address=>uint) votes;
    mapping(address=>bool) hasVoted;
    uint numCandidates;
    bool isVotingPhaseDone;
    bool hasClaimedReward;
    address winner;

    address owner;
    constructor() {
        owner = msg.sender;
    }

    function enroll() public payable {
        // Write your code here
        require(msg.value == 1 ether);
        require(numCandidates < 3);
        require(!isCandidate[msg.sender]);
        numCandidates++;
        isCandidate[msg.sender] = true;
    }

    function vote(address candidate) public payable {
        // Write your code here
        require(msg.value == 10000);
        require(!hasVoted[msg.sender]);
        require(isCandidate[candidate]);
        require(!isVotingPhaseDone);
        hasVoted[msg.sender] = true;
        votes[candidate]++;
        if (votes[candidate] >= 5) {
            winner = candidate;
            isVotingPhaseDone = true;
        }
    }

    function getWinner() public view returns (address) {
        // Write your code here
        require(isVotingPhaseDone);
        return winner;
    }

    function claimReward() public {
        // Write your code here
        require(msg.sender == getWinner());
        require(!hasClaimedReward);
        hasClaimedReward = true;
        payable(getWinner()).call{value: 3 ether}("");
    }

    function collectFees() public {
        // Write your code here
        require(msg.sender == owner);
        require(isVotingPhaseDone);
        require(hasClaimedReward);
        // payable(owner).call{value: address(this).balance}("");
        selfdestruct(payable(owner));
    }
}
