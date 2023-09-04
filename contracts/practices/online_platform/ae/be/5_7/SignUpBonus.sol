pragma solidity >=0.4.22 <=0.8.17;

abstract contract SignUpBonus {
    // Write your code here
    mapping(address => uint) balances;
    mapping(address => bool) hasDeposited;

    function getBonusAmount() internal virtual returns (uint);

    function getBonusRequirement() internal virtual returns (uint);

    function deposit() public payable {
        uint value = msg.value;
        address sender = msg.sender;
        bool isFirstDeposit = !hasDeposited[sender];

        if (isFirstDeposit && value >= getBonusRequirement()) {
            value += getBonusAmount();
        }

        hasDeposited[sender] = true;
        balances[sender] += value;
    }

    function withdraw(uint amount) public {
        address sender = msg.sender;
        require(amount <= balances[sender]);
        balances[sender] -= amount;
        (bool result, ) = payable(sender).call{value: amount}("");
        require(result);
    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}

contract Bank is SignUpBonus {
    // Write your code here
    function getBonusAmount() internal pure override returns (uint) {
        return 150;
    }

    function getBonusRequirement() internal pure override returns (uint) {
        return 1000;
    }
}
