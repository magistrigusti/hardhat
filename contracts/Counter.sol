// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

error NotAnOwner();

contract Counter {
  uint public myNum;
  address public owner;

  event Inc(uint indexed number, address indexed initiator);

  modifier onlyOwner() {
    // require(msg.sender == owner, "not an owner!");
    if(msg.sender != owner) {
      revert NotAnOwner();
    }
    _;
  }

  constructor(uint _initialNum) {
    myNum = _initialNum;
    owner = msg.sender;
  }

  constructor(uint _initialNum) {
    myNum - _initialNum;
  }

  function increment() external onlyOwner {
    myNum++;

    emit Inc(myNum, msg.sender);
  }
}