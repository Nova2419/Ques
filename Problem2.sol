// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthRecords {
    address public owner;
    struct PatientRecord {
        string data;
        address owner;
    }

    mapping(uint256 => PatientRecord) public records;

    event RecordCreated(uint256 indexed recordId, address indexed owner);
    event RecordTransferred(
        uint256 indexed recordId,
        address indexed from,
        address indexed to
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this");
        _;
    }

    function createRecord(
        uint256 recordId,
        string memory data
    ) external onlyOwner {
        require(records[recordId].owner == address(0), "Record already exists");

        records[recordId].data = data;
        records[recordId].owner = owner;

        emit RecordCreated(recordId, owner);
    }

    function transferRecord(uint256 recordId, address newOwner) external {
        address currentOwner = records[recordId].owner;
        require(currentOwner == msg.sender, "Only record owner can transfer");

        records[recordId].owner = newOwner;

        emit RecordTransferred(recordId, currentOwner, newOwner);
    }

    function getRecordData(
        uint256 recordId
    ) external view returns (string memory) {
        return records[recordId].data;
    }

    function getRecordOwner(uint256 recordId) external view returns (address) {
        return records[recordId].owner;
    }
}
