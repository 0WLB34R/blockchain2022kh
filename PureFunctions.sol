// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract PureViewRead{

    bool public myBoolean;
    string public myString;
    uint public myNumber;
    mapping(uint => bool) public myMapping;
    mapping(address => uint) public myAddresses;

    function convertWeiToEth(uint weimnt) public pure returns(uint){
        return weimnt/ 1 ether;
    }

    function convertEthToWei(uint eth) public pure returns(uint){
        return eth * 1 ether;
    }

    function receiveMoney() public payable{
        myAddresses[msg.sender] += msg.value;
    }

     function withdrawMoneyIf(uint _amount) public{
         uint amountToEther = convertEthToWei(_amount);
         if(amountToEther <= myAddresses[msg.sender]){

        myAddresses[msg.sender] -= amountToEther;
        address myWallet = msg.sender;
        payable(myWallet).transfer(amountToEther);
         }
    }

     function withdrawMoneyRequired(uint _amount) public{
        uint amountToEther = convertEthToWei(_amount);
        require(amountToEther <= myAddresses[msg.sender],"Not enough money");
        myAddresses[msg.sender] -= amountToEther;
        address myWallet = msg.sender;
        payable(myWallet).transfer(amountToEther);
    }

    function setValue(uint _index, bool value) public {
        myMapping[_index] = value;
    }

    function setMyAdresses(address _wallet, uint _amount) public{
        myAddresses[_wallet] = _amount;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }


}