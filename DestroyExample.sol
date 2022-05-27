// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract PausedDestory{

    address private owner;
    bool public paused;

    constructor(){
        owner = msg.sender;
    }

    function setPaused(bool value) public{
        paused = value;
    }

    function depositMoney() payable public{

    }

    function withdrawAllMoney() public{
        require(msg.sender == owner, "Must be the same owner");
        require(!paused, "Contract must be running");
        payable(msg.sender).transfer(address(this).balance);
    }

    function destroyContract(address payable to) public{
        require(msg.sender == owner, "Must be the same owner");
        require(!paused, "Contract must be running");
        selfdestruct(to);
    }
}