// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract MyToken {
  function tokenURI(string memory tokenId) external pure returns (string memory) {
    string memory baseURI = "ipfs://"; // https://externale.com/nfts/

    return bytes(baseURI).length > 0 
    ? string(abi.encodePacked(baseURI, tokenId))
    : "";
  } 

  function baseURI() public virtual returns(string memory) {
    return "ipfs://";
  }

  function transfer() external {
    _beforeTokenTransfer();
    // doing transfer
    _afterTokenTransfer();
  }

  function _beforeTokenTransfer() internal virtual {
    // doing before operations
  }

  function _afterTokenTransfer() internal virtual {
    // doing after operations...
  }

}

contract MyTokenOverrride is MyToken {
  function baseURI() public override returns(string memory) {
    return "https://";
  }

  // function _beforeTokenTransfer() inrenal override {

  // }
}