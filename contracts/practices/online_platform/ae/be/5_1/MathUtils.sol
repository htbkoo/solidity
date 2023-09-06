pragma solidity >=0.4.22 <=0.8.17;

contract MathUtils {
    function floor(int256 value) public pure returns (int256) {
        // Write your code here
        return value / 10 * 10;
    }

    function ceil(int256 value) public pure returns (int256) {
        // Write your code here
        if (value >= 0) {
            return floor(value + 9);
        } else {
            return floor(value - 9);
        }
    }

    function average(int256[] memory values, bool down)
        public
        pure
        returns (int256)
    {
        // Write your code here
        int count = int(values.length);
        if (count == 0) {
            return 0;
        }

        int256 total = 0;
        // for (int256 value: values) {
        for (uint i = 0; i < values.length; ++i) {
            int256 value = values[i];
            total += value;
        }

        if (down) {
            // return total / count;
            return floor(total / count);
        } else {
            // return (total + count - 1) / count;
            return ceil(total / count);
        }
    }
}
