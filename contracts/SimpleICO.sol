pragma solidity ^0.4.24;

contract SimpleICO {

    /* This creates an array with all balances */
    mapping (address => uint256) balanceOf;
    address owner;
    
    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor(uint256 initialSupply) public {
        require(initialSupply > 0);
        balanceOf[msg.sender] = initialSupply;                 // Give the creator all initial tokens
        owner = msg.sender;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) private {
        require(balanceOf[owner] >= _value);                   // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]);    // Check for overflows
        balanceOf[owner] -= _value;                            // Subtract from the sender
        balanceOf[_to] += _value;                              // Add the same to the recipient
    }
    
    function transferFunds() public payable {
        uint256 tokens = 100 * (msg.value / 1 ether);
        transfer(msg.sender, tokens);                           // Add the same to the recipient
    }
    
    function getBalance() public view returns(uint256) {
        return balanceOf[msg.sender];
    }
    
}

