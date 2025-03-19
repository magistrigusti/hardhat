// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Dominum is Ownable {
  ERC20 public DOMToken;
  uint256 public constant TOTAL_SUPPLY = 15_000_000 * 10**18;
  uint256 public constant FIRST_MONTH_ALLOCATION = (TOTAL_SUPPLY * 50) / 100;
  uint256 public constant NEXT_FIVE_MONTHS_ALLOCATION = (TOTAL_SUPPLY * 20) / 100;
  uint256 public constant FIRST_YEAR_ALLOCATION = (TOTAL_SUPPLY * 85) / 100;
  uint256 public constant SECOND_YEAR_ALLOCATION = (TOTAL_SUPPLY * 10) / 100;
  uint256 public constant THIRD_YEAR_ALLOCATION = (TOTAL_SUPPLY * 5) / 100;
  uint256 public constant MINT_PERIOD = 30 days;
  uint256 public constant INFLATION_RATE = 100;
  uint256 public constant TAX_RATE = 10;

  address public immutable inflationWallet;
  address public immutable taxWallet;
  uint256 public startTime;
  uint256 public totalMined;
  uint256 public lastMintTime;

  mapping(address => uint256) publiclastMineTime;

  event Mined(address indexed miner, uint256 amount);
  event AdminMined(address indexed admin, uint256 amount);
  event TaxPaid(address indexed sender, uint256 amount);
  event InflationMinted(uint256 amount);

  constructor(address _DOMToken, address _inflationWallet, address _taxWallet) {
    require(_inflationWallet != address(0), "Ivalid inflation wallet");
    require(_taxWallet != address(0), "Invalid tax wallet");

    DOMToken = ERC20(_DOMToken);
    inflationWallet = _inflationWallet;
    taxWallet = _taxWallet;
    statTime = block.timestamp;
    lastMintTime = block.timestamp;
  }

  function mine() external {
    require(block.timestamp >= lastMineTime[msg.sender] + MINT_PERIOD, "Wait before mining again");
    require(totalMined < TOTAL_SUPPLY, "Max supply reached");

    uint256 elapsedTime = block.timestamp - startTime;
    uint256 reward = getReward(elapsedTime);

    lastMineTime[msg.sender] = block.timestamp;
    totalMined += reward;
    DOMToken.transfer(msg.sender, reward);
    
    emit Mined(msg.sender, reward);
  }

  function adminMine(address to, uint256 amount) external onlyOwner {
    require(totalMined + amount <= TOTAL_SUPPLY, "Max supply reached");

    totalMined += amount;
    DOMToken.transfer(to, amount);

    emit AdminMined(to, amount);
  }

  function applyTax(address sender, address recipient, uint256 amount) external {
    uint256 taxAmount = (amount * TAX_RATE) / 10000;
    uint256 sendAmount = amount - taxAmount;

    DOMToken.transferFrom(sender, taxWallet, taxAmount);
    DOMToken.transferFrom(sender, recipient, sendAmount);

    emit TaxPaid(sender, taxAmount);
  }

  function mintInflation() external onlyOwner {
    require(block.timestamp >= lastMintTime + 90 days, "Inflation mining only every 3 months");

    uint256 inflationAmount = (TOTAL_SUPPLY * INFLATION_RATE) / 10000;
    totalMined += inflationAmount;
    DOMToken.transfer(inflationWallet, inflationAmount);

    emit InflationMinted(inflationAmount);
    lastMintTime = block.timestamp;
  }

  function getReward(uint256 elapsedTime) internal view returns (uint256) {
    if (elapsedTime < 30 days) {
      return FIRST_MONTH_ALLOCATION / 30;
    } else if (elapsedTime < 6 * 30 days) {
      return NEXT_FIVE_MONTHS_ALLOCATION / (5 * 30); 
    } else if (elapsedTime < 12 * 30 days) {
      return (FIRST_YEARS_ALLOCATION - FIRST_MONTH_ALLOCATION - NEXT_FIVE_MONTHS_ALLOCATION) / (6 * 30);
    } else if (elapsedTime <24 * 30 days) {
      return SECOND_YEAR_ALLOCATION / (12 * 30);
    } else if (elapsedTime < 36 * 30 days) {
      return THIRD_YEAR_ALLOCATION / (12 * 30);
    }
    
    return 0;
  }
}