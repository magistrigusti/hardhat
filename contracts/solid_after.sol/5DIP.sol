// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface ILogger {
  function log(string calldata message) external;
}

contract LoggerA is ILogger {
  event LogA(string message, uint timestamp);

  function log(string calldata message) external {
    emit LogA(message, block.timestamp);
  }
}

contract LoggerB is ILogger {
  event LogB(
    string indexed message, 
    uint indexed timestamp,
    string messageRaw
  );

  function log(string calldata message) external {
    emit LogB(message, block.timestamp, message);
  }
}

contract Demo {
  function doWork(string calldata message, address logger) external {
    // doing work...
    ILogger(logger).log(message);
  }
}