pragma solidity >=0.4.22 <=0.8.17;

contract Comparison {
    function compare(int256 a, int256 b) public pure returns (int256) {
        // Write your code here
        // return (a == b) ? 0 : ((a > b) ? 1 : -1);
        return a == b ? int256(0) : a > b ? int256(1) : int256(-1);
    }
}
