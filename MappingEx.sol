// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ModifierExample{

    bool public myBoolean;
    string public myString;
    uint public myNumber;
    mapping(uint => bool) public myMapping;
    mapping(address => uint) public myAddresses;

    function setValue(uint _index, bool value) public {
        myMapping[_index] = value;
    }

    function setMyAdresses(address _wallet, uint _amount) public{
        myAddresses[_wallet] = _amount;
    }
}