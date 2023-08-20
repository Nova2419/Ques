// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductRegistry {
    struct Product {
        uint timestamp;
        string name;
        string description;
    }

    mapping(address => Product) public products;

    event ProductAdded(address indexed owner, string name);

    modifier onlyOwner(address productOwner) {
        require(msg.sender == productOwner, "You are not the owner.");
        _;
    }

    function addProduct(
        string memory _name,
        string memory _description
    ) public {
        Product memory newProduct = Product(
            block.timestamp,
            _name,
            _description
        );
        products[msg.sender] = newProduct;
        emit ProductAdded(msg.sender, _name);
    }

    function getProductDetails(
        address productOwner
    ) public view returns (Product memory) {
        return products[productOwner];
    }

    function updateProductDetails(
        string memory _name,
        string memory _description
    ) public onlyOwner(msg.sender) {
        products[msg.sender].name = _name;
        products[msg.sender].description = _description;
    }
}
