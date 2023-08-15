// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Problem4 {
    address public admin;
    uint256 public totalCandidates;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    event Voted(address indexed voter, uint256 candidateId);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    modifier notVoted() {
        require(!hasVoted[msg.sender], "You have already voted");
        _;
    }

    function addCandidate(string memory _name) external onlyAdmin {
        totalCandidates++;
        candidates[totalCandidates] = Candidate(_name, 0);
    }

    function vote(uint256 candidateId) external notVoted {
        require(
            candidateId > 0 && candidateId <= totalCandidates,
            "Invalid candidate ID"
        );
        candidates[candidateId].voteCount++;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, candidateId);
    }

    function getCandidate(
        uint256 candidateId
    ) external view returns (string memory, uint256) {
        require(
            candidateId > 0 && candidateId <= totalCandidates,
            "Invalid candidate ID"
        );
        Candidate memory candidate = candidates[candidateId];
        return (candidate.name, candidate.voteCount);
    }
}
