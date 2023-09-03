pragma solidity >=0.4.22 <=0.8.17;

contract AdvancedCounter {
    mapping(address=>mapping(string=>int256)) counters;
    mapping(address=>mapping(string=>bool)) counterIds;
    mapping(address=>uint) numCounters;

    function createCounter(string memory id, int256 value) public {
        // Write your code here
        require(numCounters[msg.sender] < 3);
        require(!counterIds[msg.sender][id]);

        numCounters[msg.sender]++;
        counterIds[msg.sender][id] = true;

        counters[msg.sender][id] = value;
    }

    function deleteCounter(string memory id) public {
        // Write your code here
        require(counterIds[msg.sender][id]);

        numCounters[msg.sender]--;
        counterIds[msg.sender][id] = false;

        delete counters[msg.sender][id];
    }

    function incrementCounter(string memory id) public {
        // Write your code here
        require(counterIds[msg.sender][id]);
        counters[msg.sender][id]++;
    }

    function decrementCounter(string memory id) public {
        // Write your code here
        require(counterIds[msg.sender][id]);
        counters[msg.sender][id]--;
    }

    function getCount(string memory id) public view returns (int256) {
        // Write your code here
        require(counterIds[msg.sender][id]);
        return counters[msg.sender][id];
    }
}
