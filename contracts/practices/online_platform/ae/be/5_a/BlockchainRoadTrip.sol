pragma solidity >=0.4.22 <=0.8.17;

interface Driveable {
    // Write your code here
    function startEngine() external;
    function stopEngine() external;
    function fuelUp(uint litres) external;
    function drive(uint kilometers) external;
    function kilometersRemaining() external view returns (uint);
}

abstract contract GasVehicle is Driveable {
    // Write your code here
    function getKilometersPerLitre() public virtual returns (uint);
    function getFuelCapacity() public virtual returns (uint);
}

contract Car is GasVehicle {
    // Write your code here
    bool isEngineStarted;
    uint remainFuel;
    uint _fuelTankSize;
    uint _kilometersPerLitre;
    constructor(uint fuelTankSize, uint kilometersPerLitre) {
        _fuelTankSize = fuelTankSize;
        _kilometersPerLitre = kilometersPerLitre;
    }

    function startEngine() public override {
        isEngineStarted = true;
    }
    function stopEngine() public override {
        isEngineStarted = false;
    }
    function fuelUp(uint litres) public override {
        require(!isEngineStarted);
        require(remainFuel + litres <= _fuelTankSize);
        remainFuel += litres;
    }
    function drive(uint kilometers) public override {
        require(isEngineStarted);
        require(kilometers <= _kilometersPerLitre * remainFuel);
        remainFuel -= kilometers / _kilometersPerLitre;
    }
    function kilometersRemaining() public override view returns (uint) {
        return remainFuel * _kilometersPerLitre;
    }
    function getKilometersPerLitre() public override view returns (uint) {
        return _kilometersPerLitre;
    }
    function getFuelCapacity() public override view returns (uint) {
        return _fuelTankSize;
    }
}
