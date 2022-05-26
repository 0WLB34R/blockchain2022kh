// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract StructTest{
    struct Book{
        string title;
        string author;
        uint id;
        bool available;
    }

    Book public book;

    function setTitle(string memory title) public{
        book.title = title;
    }

    function getTitle() view public returns(string memory){
        return book.title;
    }
}