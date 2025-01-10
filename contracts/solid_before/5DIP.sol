// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Base {
  uint public amount;
  address[] children;

  constructor() {
    // deploy child
    // address newChild = address(new Child())
    // children.push(newChild); 
  }

  function setAmount(uint _amount) public {
    amount = _amount;
  }
}

contract Cnild {
  address parent;

  constructor() {
    parent = msg.sender;
    Base(parent).amount();
  }
}

contract LoggerA {
  event LogA(string message, uint timestamp);

  function log(string memory message) external {
    emit LogA(message, block.timestamp);
  }
}

contract LoggerB {
  event LogB(
    string indexed message, 
    uint indexed timestamp,
    string messageRaw
  );
}

contract Demo {
  LoggerA private loggerA;
  LoggerB private loggerB;

  constructor(address _loggerA, address _loggerB) {
    loggerA = LoggerA(_loggerA);
    loggerB = LoggerB(_loggerB);
  }

  function doWork() external {
    // doing work..
    logA("done!");
  }

  function logA(string memory message) public {
    loggerA.log(message);
  }

  function logB(string memory message) public {
    loggerB.log(message);
  }
}