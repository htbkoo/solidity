pragma solidity >=0.4.22 <=0.8.17;

contract GridMaker {
    function make2DIntGrid(
        uint256 rows,
        uint256 cols,
        int256 value
    ) public pure returns (int256[][] memory) {
        // Write your code here
        int256[][] memory mat = new int256[][](rows);

        for (uint y = 0; y < rows; ++y) {
            mat[y] = new int256[](cols);
            for (uint x = 0; x < cols; ++x) {
                mat[y][x] = value;
            }
        }

        return mat;
    }

    function make2DAddressGrid(uint256 rows, uint256 cols)
        public
        view
        returns (address[][] memory)
    {
        // Write your code here
        address[][] memory mat = new address[][](rows);

        for (uint y = 0; y < rows; ++y) {
            mat[y] = new address[](cols);
            for (uint x = 0; x < cols; ++x) {
                mat[y][x] = msg.sender;
            }
        }

        return mat;
    }
}
