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
    Book public book2 = Book("title", "ken", 2, false);

    function setTitle(string memory title) public{
        book.title = title;
    }

    function getTitle() view public returns(string memory){
        return book.title;
    }

    function getTitleAndId() view public returns(string memory, uint){
        return (book2.title,book2.id);
    }
}