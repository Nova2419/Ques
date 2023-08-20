// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DistributedLedger {
    struct Transaction {
        uint timestamp;
        address sender;
        address receiver;
        uint amount;
        string transactionId;
    }

    Transaction[] public transactions;
    mapping(address => bytes32) public nodeIdentifiers;

    constructor() {
        nodeIdentifiers[msg.sender] = keccak256(abi.encodePacked(msg.sender));
    }

    modifier onlyValidNode() {
        require(nodeIdentifiers[msg.sender] != bytes32(0), "Invalid node.");
        _;
    }

    function addTransaction(
        address _receiver,
        uint _amount,
        string memory _transactionId
    ) public onlyValidNode {
        Transaction memory newTransaction = Transaction(
            block.timestamp,
            msg.sender,
            _receiver,
            _amount,
            _transactionId
        );
        transactions.push(newTransaction);
    }

    function getNodeIdentifier() public view returns (bytes32) {
        return nodeIdentifiers[msg.sender];
    }

    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    function getTransaction(
        uint index
    ) public view returns (Transaction memory) {
        require(index < transactions.length, "Transaction index out of bounds");
        return transactions[index];
    }
}
