pragma solidity >=0.4.22 <=0.8.17;

contract DebtTracking {
    // Write your code here
    mapping(address => mapping(address => uint)) owing;

    function addDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        owing[payingAddress][toBePaidAddress] += amount;
    }

    function payDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        if (amount > owing[payingAddress][toBePaidAddress]) {
            owing[toBePaidAddress][payingAddress] += amount - owing[payingAddress][toBePaidAddress];
            owing[payingAddress][toBePaidAddress] = 0;
        } else {
            owing[payingAddress][toBePaidAddress] -= amount;
        }
    }

    function getDebt(address toBePaidAddress, address payingAddress)
        public
        view
        returns (uint256)
    {
        return owing[payingAddress][toBePaidAddress];
    }
}
