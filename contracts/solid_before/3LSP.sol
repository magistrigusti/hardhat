// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract BaseToken {
  constructor() {}

  function transfer(address to, uint amount) external view virtual returns(bool) {
      // ...
  }
}

contract TokenA is BaseToken {
  function transfer(address to, uint amount) external pure override returns(bool) {
    // transfer...
  }
}

contract TokenB is BaseToken {
  function transfer(address to, uint amount, bytes memory data) external {
    // transfer...
  }
}