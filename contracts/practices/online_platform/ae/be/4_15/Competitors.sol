pragma solidity >=0.4.22 <=0.8.17;

contract Competitors {
    // Write your code here
    mapping(address => uint) counts;
    address[] addresses;
    uint totalCount;
    bool hasWithdrawn;
    address deployer;
    address mostUser;

    constructor() {
        deployer = msg.sender;
    }

    function deposit() public payable {
        require(msg.value == 1 ether);
        require(totalCount < 3);
        if (addresses.length >= 2) {
            require(counts[msg.sender] > 0);
        } else {
            addresses.push(msg.sender);
        }

        totalCount++;
        counts[msg.sender]++;
        if (counts[msg.sender] > counts[mostUser]) {
            mostUser = msg.sender;
        }
    }

    function withdraw() public {
        require(msg.sender == mostUser);
        require(totalCount == 3);
        uint value = totalCount;
        totalCount = 0;
        hasWithdrawn = true;
        payable(msg.sender).call{value: address(this).balance}("");
    }

    function destroy() public {
        require(msg.sender == deployer);
        require(hasWithdrawn);
        selfdestruct(payable(deployer));
    }
}
