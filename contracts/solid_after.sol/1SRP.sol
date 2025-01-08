// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Ownership {
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

contract MyToken is Ownership {
  function approve() external {
    // approving for operator
  }

  function transfer() external {
    // transfer tokens
  }
}