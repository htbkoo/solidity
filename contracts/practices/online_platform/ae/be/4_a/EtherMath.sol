pragma solidity >=0.4.22 <=0.8.17;

contract EtherMath {
    int256[] challengeArray;
    mapping(int256=>uint) challengeArrayCounter;
    int256 challengeTargetSum;
    uint reward;
    mapping(address=>uint) rewards;

    mapping(address=>bool) hasSubmitted;
    address[] submittedUsers;

    address owner;
    constructor() {
        owner = msg.sender;
    }

    function submitChallenge(int256[] memory array, int256 targetSum)
        public
        payable
    {
        // Write your code here
        require(msg.value > 0);
        require(msg.sender == owner);
        require(reward == 0);

        reward = msg.value;
        challengeArray = array;
        for (uint i = 0; i < array.length; ++i) {
            challengeArrayCounter[array[i]]++;
        }
        challengeTargetSum = targetSum;
    }

    function submitSolution(int256[] memory solution) public {
        // Write your code here
        require(reward > 0);
        require(!hasSubmitted[msg.sender]);

        hasSubmitted[msg.sender] = true;
        submittedUsers.push(msg.sender);

        int256 sum = 0;
        // mapping(int256=>uint) memory counter;
        for (uint i = 0; i < solution.length; ++i) {
            int256 num = solution[i];
            require(challengeArrayCounter[num] > 0);
            sum += num;
        }

        bool isSolved = sum == challengeTargetSum;
        if (isSolved) {
            for (uint i = 0; i < challengeArray.length; ++i) {
                delete challengeArrayCounter[challengeArray[i]];
            }
            rewards[msg.sender] += reward;
            reward = 0;

            for (uint i = 0; i < submittedUsers.length; ++i) {
                delete hasSubmitted[submittedUsers[i]];
            }
            delete submittedUsers;
        }
    }

    function claimRewards() public {
        // Write your code here
        uint value = rewards[msg.sender];
        rewards[msg.sender] = 0;
        payable(msg.sender).call{value: value}("");
    }
}
