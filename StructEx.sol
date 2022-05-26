// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract StructTest{
    struct Book{
        string title;
        string author;
        uint id;
        bool available;
        uint quantity;
    }

    Book public book;
    Book public book2 = Book("title", "ken", 2, false, 3);

    mapping(uint => Book) bookLibrary;

    function getBook(uint idBook) public view returns(bool,uint){
        return (bookLibrary[idBook].available, bookLibrary[idBook].quantity);
    }

    function addBook(Book memory newBook)public{
        bookLibrary[newBook.id]=newBook;
    }

    function borrowBook(uint idBook) public{
        bookLibrary[idBook].quantity--;
    }

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