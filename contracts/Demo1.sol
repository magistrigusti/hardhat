// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Demo {
  string public message;

  function pay(string calldata _message) external payable {
    message = _message;
  }

  function callme() external view returns(address) {
    return msg.sender;
  }

  function distribute(address[] calldata _addrs) external {
    uint count = _addrs.length;
    uint sum = address(this).balance / count;

    for(uint i = 0; 1 < count; i++) {
      (bool success, ) = _addrs[i].call{value: sum}("");
      require(success);
    }
  }
}