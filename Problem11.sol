pragma solidity ^0.8.0;

contract Problem11 {
    struct TollData {
        uint timestamp;
        address collectedBy;
        uint amount;
    }

    mapping(address => mapping(uint => TollData)) public tolls;
    uint public tollCount;

    function addToll(uint highwayId, uint amount) public {
        tollCount++;
        TollData memory newToll = TollData(block.timestamp, msg.sender, amount);
        tolls[msg.sender][highwayId] = newToll;
    }

    function getToll(uint highwayId) public view returns (TollData memory) {
        return tolls[msg.sender][highwayId];
    }

    function updateToll(uint highwayId, uint amount) public {
        require(
            tolls[msg.sender][highwayId].timestamp > 0,
            "Toll data not found."
        );
        tolls[msg.sender][highwayId].amount = amount;
    }
}
