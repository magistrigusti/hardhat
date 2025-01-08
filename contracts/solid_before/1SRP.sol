// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract MyToken {
  function approve() external {
    // approing for operator
  }

  function transfer() external {
    // transfering tokens
  }

  modifier onlyOwner() {
    // require()
    _;
  }

  function removeOwner() external {
    // removing an owner
  }

  function addOwner() external {
    // adding a new owner
  }
}