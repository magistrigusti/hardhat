// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Demo {
  address[] public participants;
  address[] public failedRefunds;
  mapping(address => uint) public bets;

  function refund() external {
    uint length = participants.length;

    for(uint i = 0; i < length; i++) {
      address nextParticipant = participants[i];

      (bool ok, ) = nextParticipant.call{value: bets[nextParticipant]}("");
      require(ok, "failed");
      // if(!ok) {failedRefunds.push(nextParticipant); }
    }
  }

  receive() external payable {
    participants.push(msg.sender);
    bets[msg.sender] = msg.value;
  }
}