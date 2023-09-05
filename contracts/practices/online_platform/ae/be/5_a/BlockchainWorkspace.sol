pragma solidity >=0.4.22 <=0.8.17;

contract Employee {
    // Write your code here
    enum Department {
        Gardening,
        Clothing,
        Tools
    }

    string _firstName;
    string _lastName;
    uint _hourlyPay;
    uint _department;

    constructor(string memory firstName, string memory lastName, uint hourlyPay, uint department) {
        _firstName = firstName;
        _lastName = lastName;
        _hourlyPay = hourlyPay;
        _department = department;
    }

    function getWeeklyPay(uint hoursWorked) public view returns (uint) {
        if (hoursWorked <= 40) {
            return hoursWorked * _hourlyPay;
        } else {
            return 40 * _hourlyPay + (hoursWorked - 40) * 2 * _hourlyPay;
        }
    }

    function getFirstName() public view returns (string memory) {
        return _firstName;
    }
}

contract Manager is Employee {
    // Write tour code here
    Employee[] subordinates;
    string[] firstNames;

    constructor(string memory firstName, string memory lastName, uint hourlyPay, uint department) Employee(firstName, lastName, hourlyPay, department) {
    }

    function addSubordinate(string memory firstName, string memory lastName, uint hourlyPay, uint department) public {
        Employee employee = new Employee(firstName, lastName, hourlyPay, department);
        subordinates.push(employee);
        firstNames.push(firstName);
    }

    function getSubordinates() public view returns (string[] memory) {
        // string[] storage firstNames;
        // for (uint i = 0; i < subordinates.length; ++i) {
        //     firstNames.push(subordinates[i].getFirstName());
        // }
        return firstNames;
    }
}
