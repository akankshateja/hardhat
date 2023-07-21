// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Token {
    // Public variables here
    string public tokenName = "TOken";
    string public abbrv = "TKN";
    uint public totalSupply = 0;
    address public owner;

    // Mapping variable here
    mapping (address => uint) public balances;

    // Events
    event Minted(address indexed _to, uint _value);
    event Burned(address indexed _from, uint _value);

    // Modifier to restrict functions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Mint function
    function mint(address _address, uint _value) public onlyOwner {
        totalSupply += _value;
        balances[_address] += _value;
        emit Minted(_address, _value);
    }

    // Burn function
    function burn(address _address, uint _value) public onlyOwner {
        if (balances[_address] >= _value) {
            totalSupply -= _value;
            balances[_address] -= _value;
            emit Burned(_address, _value);
        }
    }
     function transfer(address to, uint256 amount) external {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Invalid amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
    }
}
