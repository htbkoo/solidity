pragma solidity >=0.4.22 <=0.8.17;

contract LargestHolder {
    uint public constant MAX_NUM_ITERATIONS_PER_TX = 10;

    uint256[] balances;
    address[] holders;
    bool hasSubmitted;
    bool hasDeterminedLargest;
    uint currIdx;
    uint largestIdx;

    function submitBalances(
        uint256[] memory _balances,
        address[] memory _holders
    ) public {
        // Write your code here
        balances = _balances;
        holders = _holders;
        hasSubmitted = true;

        // TODO: confirm these
        require(balances.length > 0);
        require(balances.length == holders.length);
    }

    modifier requireSubmitted {
        require(hasSubmitted);
        _;
    }

    function process() public requireSubmitted {
        // Write your code here
        require(!hasDeterminedLargest);

        for (uint i = 0; i < MAX_NUM_ITERATIONS_PER_TX; ++i) {
            // TODO: clarify, what if equal / multiple largest
            if (balances[currIdx] > balances[largestIdx]) {
                largestIdx = currIdx;
            }

            currIdx++;

            if (currIdx >= balances.length) {
                hasDeterminedLargest = true;
                break;
            }
        }
    }

    function numberOfTxRequired() public view requireSubmitted returns (uint256) {
        // Write your code here
        return (balances.length - currIdx + MAX_NUM_ITERATIONS_PER_TX - 1) / MAX_NUM_ITERATIONS_PER_TX;
    }

    function getLargestHolder() public view requireSubmitted returns (address) {
        // Write your code here
        require(hasDeterminedLargest);
        return holders[largestIdx];
    }
}
