// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalAssetRegistry {
    struct DigitalAsset {
        address owner;
        bool exists;
        string details;
    }

    mapping(string => DigitalAsset) public assets;

    event AssetRegistered(
        address indexed owner,
        string assetId,
        string details
    );
    event AssetDetailsUpdated(string assetId, string newDetails);

    modifier assetNotExists(string memory _assetId) {
        require(!assets[_assetId].exists, "Asset with this ID already exists.");
        _;
    }

    modifier onlyOwner(string memory _assetId) {
        require(
            msg.sender == assets[_assetId].owner,
            "Only the asset owner can call this function."
        );
        _;
    }

    function registerAsset(
        string memory _assetId,
        string memory _details
    ) public assetNotExists(_assetId) {
        DigitalAsset memory newAsset = DigitalAsset(msg.sender, true, _details);
        assets[_assetId] = newAsset;
        emit AssetRegistered(msg.sender, _assetId, _details);
    }

    function updateAssetDetails(
        string memory _assetId,
        string memory _newDetails
    ) public onlyOwner(_assetId) {
        assets[_assetId].details = _newDetails;
        emit AssetDetailsUpdated(_assetId, _newDetails);
    }
}
