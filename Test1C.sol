// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

//Goerli deployment @: 0xb2c4d5b4326d92ef7a5d3944018be45f61480dd3ae0c23b3e2a2f88a19fd6271

contract university{

    address private professor;
    bool private closed = false;
    event congrats(string name, string message);

    struct Grade {
        uint id;
        string name;
        uint score;
        bool finalized;
        uint typeTest;
    }

    mapping(uint => Grade) public gradeBook;

    constructor(){
        professor = msg.sender;
    }

    function insertGrade(uint id, string memory name) public isProfessor(msg.sender) isClosed{
        require(gradeBook[id].id == 0,"That student already exists");
        require(id != 0,"A student's id cannot be 0");
        require(bytes(name).length > 5, "The student's name should be longer than 5 characters");
        gradeBook[id] = Grade(id,name,0,false,0);
    }

    function finalGrade(uint id, uint score)public isProfessor(msg.sender) studentExists(id) isClosed{
        require(gradeBook[id].finalized == false, "This grade has been marked as final");
        require(score <= 100,"Score cannot be above 100");
        require(score >= 0,"Score cannot be below 0");
        gradeBook[id].finalized = true;
        if(gradeBook[id].typeTest == 0){
        gradeBook[id].typeTest = 1;
        }
        gradeBook[id].score = score;

        if(score > 90){
            gradeBook[id].score=100;
            emit congrats(gradeBook[id].name, "Congratulations!");
        }
    }

    function request2T(uint id) public payable studentExists(id) isClosed{
        require(gradeBook[id].finalized, "Your final grade has not been posted");
        require(gradeBook[id].typeTest == 1, "You have already requested a T2");
        require(wei2eth(msg.value) == 10, "The university's fee for this request is 10 Eth");
        gradeBook[id].score = 0;
        gradeBook[id].typeTest = 2;
        gradeBook[id].finalized = false;
    }

    function checkGrade(uint id)public view isClosed studentExists(id) returns(Grade memory){
        return gradeBook[id];
    }

    function openCloseSystem(bool val) public isProfessor(msg.sender){
        closed = val;
    }

    function checkBalance() public view isProfessor(msg.sender) returns(uint) {
        return wei2eth(address(this).balance);
    }

    function wei2eth(uint weiAmount) private pure returns(uint){
        return weiAmount / 1 ether;
    }

    modifier isProfessor(address addToCheck){
        require(professor == addToCheck, "You are not a professor");
        _;
    }

    modifier isClosed() {
        require(!closed, "The system is closed");
        _;
    }

    modifier studentExists(uint id){
        require(gradeBook[id].id != 0, "That student does not exist");
        _;
    }
}