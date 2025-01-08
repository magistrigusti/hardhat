// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IToken {
  function transfer(address to, uint amount) external;

  function transferFrom(address from, address to, uint amount) external;

  function approve(address to, bool status) external;

  function removeOwner(address owner) external;

  function addOwner(address owner) external;
}

contract MyToken is IToken {
  function transfer(address to, uint amount) external;

  function transferFrom(address from, address to, uint amount) external;

  function approve(address to, bool status) external;

  function removeOwner(address owner) external;

  function addOwner(address owner) external;
}