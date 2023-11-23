pragma solidity ^0.8.0;

contract lottery {

    address public owner;
    address payable[] public participants;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function enterGame() payable public {
        require(msg.value >= 0.01 ether, 'You do not have sufficient ether');
        participants.push(payable(msg.sender));
    }

    function amount(address participantsAddress) public view returns(uint) {
        return participantsAddress.balance;
    }

    function rand() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
    }

    function lotteryWinner() public onlyOwner {
        require (msg.sender == owner);
        uint index = rand() % participants.length;
        participants[index].transfer(address(this).balance);
        participants = new address payable[] (0);
    }   
}