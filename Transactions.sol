// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ModifierExample{

    bool public myBoolean;
    string public myString;
    uint public myNumber;
    mapping(uint => bool) public myMapping;
    mapping(address => uint) public myAddresses;

    function receiveMoney() public payable{
        myAddresses[msg.sender] += msg.value;
    }

     function withdrawMoney(uint _amount) public{
        myAddresses[msg.sender] -= _amount * (10**18);
        address myWallet = msg.sender;
        payable(myWallet).transfer(_amount * (10**18));
    }

    function setValue(uint _index, bool value) public {
        myMapping[_index] = value;
    }

    function setMyAdresses(address _wallet, uint _amount) public{
        myAddresses[_wallet] = _amount;
    }


}