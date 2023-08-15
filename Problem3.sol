// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Problem3 {
    address public owner;

    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
        address issuer;
    }

    uint256 public totalCertificates;
    mapping(uint256 => Certificate) public certificates;

    event CertificateIssued(
        uint256 indexed certificateId,
        string studentName,
        string courseName,
        uint256 issueDate,
        address indexed issuer
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this");
        _;
    }

    function issueCertificate(
        string memory studentName,
        string memory courseName,
        uint256 issueDate
    ) external onlyOwner {
        uint256 certificateId = totalCertificates + 1;

        certificates[certificateId] = Certificate({
            studentName: studentName,
            courseName: courseName,
            issueDate: issueDate,
            issuer: msg.sender
        });

        totalCertificates = certificateId;

        emit CertificateIssued(
            certificateId,
            studentName,
            courseName,
            issueDate,
            msg.sender
        );
    }

    function getCertificate(
        uint256 certificateId
    ) external view returns (string memory, string memory, uint256, address) {
        Certificate memory cert = certificates[certificateId];
        return (cert.studentName, cert.courseName, cert.issueDate, cert.issuer);
    }
}
