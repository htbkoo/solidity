pragma solidity >=0.4.22 <=0.8.17;

contract ShoppingList {
    // Write your structs here
    mapping(address => mapping(string => bool)) hasList;
    mapping(address => string[]) listNames;
    mapping(address => mapping(string => mapping(string => uint))) lists;
    mapping(address => mapping(string => mapping(string => bool))) hasItem;
    mapping(address => mapping(string => string[])) itemsNames;

    function createList(string memory name) public {
        // Write your code here
        require(bytes(name).length > 0);
        require(!hasList[msg.sender][name]);
        hasList[msg.sender][name] = true;
        listNames[msg.sender].push(name);
    }

    function getListNames() public view returns (string[] memory) {
        // Write your code here
        return listNames[msg.sender];
    }

    function getItemNames(string memory listName)
        public
        view
        returns (string[] memory)
    {
        // Write your code here
        require(hasList[msg.sender][listName]);
        return itemsNames[msg.sender][listName];
    }

    function addItem(
        string memory listName,
        string memory itemName,
        uint256 quantity
    ) public {
        // Write your code here
        require(hasList[msg.sender][listName]);
        lists[msg.sender][listName][itemName] += quantity;
        if (!hasItem[msg.sender][listName][itemName]) {
            itemsNames[msg.sender][listName].push(itemName);
            hasItem[msg.sender][listName][itemName] = true;
        }
    }
}
