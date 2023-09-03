pragma solidity >=0.4.22 <=0.8.17;

contract EventEmitter {
    // Write your code here
    event Called(address sender, uint count);

    uint c = 1;

    function count() public {
        // Write your code here
        emit Called(msg.sender, c);
        c++;
    }
}
