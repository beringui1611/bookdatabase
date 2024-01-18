 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BookDatabase {

 struct Book {
    string title;
    uint16 year;
    string author;
 }

 string public message;

 uint32 private nextId = 0;

 mapping(uint32 => Book) public books;

 address private immutable owner;

 uint256 public count;

 constructor(){
    owner = msg.sender; 
 }

 function addBook(Book memory newBook) public {
    nextId++;
    books[nextId] = newBook;
    count++;

 } 

  function editBook(uint32 id, Book memory newBook) public {
        Book memory oldBook = books[id];

        if(!compare(oldBook.title, newBook.title) && !compare(newBook.title, ""))
            books[id].title = newBook.title;

        if(oldBook.year != newBook.year && newBook.year > 0)
            books[id].year = newBook.year;
    }

  function compare(string memory str1, string memory str2)private  pure returns (bool){
        bytes memory arrA = bytes(str1);
        bytes memory arrB = bytes(str2);
        return arrA.length == arrB.length && keccak256(arrA) == keccak256(arrB);
    }

    function removeBook(uint32 id) public restrict {
        require(owner == msg.sender, "You dont have permission");
        if(books[id].year > 0){
            delete books[id];
            count--;
        }
        delete  books[id];
    }

    
    modifier restrict(){
        require(owner == msg.sender, "you dont have permission");
        _;
    }

}