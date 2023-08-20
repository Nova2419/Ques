// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MicroFinancing {
    struct FinancialData {
        uint timestamp;
        uint amount;
    }

    mapping(address => FinancialData) public financialRecords;

    function addFinancialData(uint amount) public {
        FinancialData memory newData = FinancialData(block.timestamp, amount);
        financialRecords[msg.sender] = newData;
    }

    function getFinancialData() public view returns (FinancialData memory) {
        return financialRecords[msg.sender];
    }

    function updateFinancialData(uint amount) public {
        financialRecords[msg.sender].amount = amount;
    }
    // More funcationalities to be added because this is a major problem in our daily life
}
