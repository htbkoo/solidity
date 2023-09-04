pragma solidity >=0.4.22 <=0.8.17;

contract Item {
    string _name;
    uint _price;

    constructor(string memory name, uint price) {
        _name = name;
        _price = price;
    }

    // Write your code here
    function getName() public view returns (string memory) {
        return _name;
    }

    function getPrice() public virtual view returns (uint) {
        return _price;
    }
}

contract TaxedItem is Item {
    // Write your code here
    uint _tax;

    constructor(string memory name, uint price, uint tax) Item(name, price) {
        _tax = tax;
    }

    function getPrice() public override view returns (uint) {
        return _price + _tax;
    }
}
