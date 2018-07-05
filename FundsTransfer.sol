pragma solidity ^0.4.23;

contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyowner(){
        if (msg.sender == owner) {
            _;
        }
    }
}

contract mortal is owned {
    function kill() public onlyowner {
        selfdestruct(owner);
    } 
}

contract FundsTransfer is mortal {

    constructor() public {
    }
    
    function sendETHToContract() public payable returns (bool success) {
        return true;
    }
    
    function getTotalETHSentToContract() public view returns (uint256) {
        return address(this).balance;
    }
    
    function sendETHTo(address _to, uint _amount) public onlyowner returns (bool success){
        require(address(this).balance >= _amount);
        _to.transfer(_amount);
        return true;
    }
    
    function getBalanceOf(address _address) public view returns (uint){
        return address(_address).balance;
    }

}
