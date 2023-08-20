// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TollFreeDataContract {
    struct TollData {
        uint timestamp;
        address operator;
        uint vehicleType;
        uint amount;
    }

    mapping(address => TollData) public tolls;

    address public owner;

    event TollAdded(
        address indexed operator,
        uint indexed vehicleType,
        uint amount
    );
    event TollUpdated(
        address indexed operator,
        uint indexed vehicleType,
        uint newAmount
    );

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function."
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setOperator(address _operator) public onlyOwner {
        owner = _operator;
    }

    function addToll(uint _vehicleType, uint _amount) public {
        TollData memory newToll = TollData(
            block.timestamp,
            msg.sender,
            _vehicleType,
            _amount
        );
        tolls[msg.sender] = newToll;
        emit TollAdded(msg.sender, _vehicleType, _amount);
    }

    function getTollDetails() public view returns (uint, address, uint, uint) {
        TollData memory tollData = tolls[msg.sender];
        return (
            tollData.timestamp,
            tollData.operator,
            tollData.vehicleType,
            tollData.amount
        );
    }

    function updateTollAmount(uint _newAmount) public onlyOwner {
        tolls[msg.sender].amount = _newAmount;
        emit TollUpdated(msg.sender, tolls[msg.sender].vehicleType, _newAmount);
    }
}
