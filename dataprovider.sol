pragma solidity ^0.8.0;

contract FoodSupplyData {
    
    address public owner;
    mapping(address => bool) public authorizedProviders;
    uint256 public pricePerData;
    
    event DataProvided(address indexed provider, string dataHash);
    
    constructor() {
        owner = msg.sender;
        authorizedProviders[msg.sender] = true;
        pricePerData = 1 ether;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }
    
    modifier onlyAuthorized() {
        require(authorizedProviders[msg.sender], "Only authorized providers can call this function.");
        _;
    }
    
    function addAuthorizedProvider(address provider) public onlyOwner {
        authorizedProviders[provider] = true;
    }
    
    function removeAuthorizedProvider(address provider) public onlyOwner {
        authorizedProviders[provider] = false;
    }
    
    function setPricePerData(uint256 price) public onlyOwner {
        pricePerData = price;
    }
    
    function provideData(string memory dataHash) public payable onlyAuthorized {
        require(msg.value == pricePerData, "Incorrect amount of ether sent.");
        emit DataProvided(msg.sender, dataHash);
    }
    
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
