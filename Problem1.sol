// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Problem1 {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this");
        _;
    }

    function mintMoney(uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than 0");
        balances[msg.sender] += amount;
    }

    function withdrawMoney(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function sendMoneyToContract() external payable {
        require(msg.value > 0, "Value must be greater than 0");
    }

    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
