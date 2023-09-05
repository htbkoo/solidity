pragma solidity >=0.4.22 <=0.8.17;

contract FancyShirts {
    // Write your code here
    enum Size {
        Small,
        Medium,
        Large
    }
    enum Color {
        Red,
        Green,
        Blue
    }

    // struct Shirt {
    //     Size size;
    //     Color color;
    // }

    // mapping(address => mapping(Shirt => uint)) counts;
    mapping(address => mapping(Size => mapping(Color =>uint))) counts;

    function getShirtPrice(Size size, Color color) public pure returns (uint) {
        uint price = 0;
        if (size == Size.Small) {
            price += 10;
        } else if (size == Size.Medium) {
            price += 15;
        } else if (size == Size.Large) {
            price += 20;
        }

        if (color == Color.Green || color == Color.Blue) {
            price += 5;
        }

        return price;
    }

    function buyShirt(Size size, Color color) public payable {
        require(msg.value == getShirtPrice(size, color));
        counts[msg.sender][size][color]++;
    }

    function getShirts(Size size, Color color) public view returns (uint) {
        return counts[msg.sender][size][color];
    }
}
