// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EventsTest{
    address private owner;
    mapping(address => uint) public tokenBalance;
    event tokenSent(address from, address to, uint amount);

    constructor(){
         owner = msg.sender;
        tokenBalance[owner] = 100;
    }

    function sendToken(address to, uint amount)public {
        require(msg.sender == owner, 'you are not the owner');
        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] += amount;

        emit tokenSent(msg.sender, to, amount);
    }
}