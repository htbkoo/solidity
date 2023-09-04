pragma solidity >=0.4.22 <=0.8.17;

library Array {
    // Write your code here
    function indexOf(int[] memory numbers, int target) public pure returns (int) {
        for (uint i = 0; i < numbers.length; ++i) {
            if (numbers[i] == target) {
                return int(i);
            }
        }
        return -1;
    }

    function count(int[] memory numbers, int target) public pure returns (uint) {
        uint count = 0;
        for (uint i = 0; i < numbers.length; ++i) {
            if (numbers[i] == target) {
                count++;
            }
        }
        return count;
    }

    function sum(int[] memory numbers) public pure returns (int) {
        int total = 0;
        for (uint i = 0; i < numbers.length; ++i) {
            total += numbers[i];
        }
        return total;
    }
}
