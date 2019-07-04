pragma solidity ^0.5.10;

import "./access/RBACWithAdmin.sol";
import "./StorageInterface.sol";
import "./CampaignInterface.sol";

contract Campaign is RBACWithAdmin, CampaignInterface {
  bool approved;
  string symbol;
  string name;

  uint32 public yieldBasisPoints;
  uint32 public numberOfShares;
  uint256 public startDate;
  uint256 public endDate;
  bool public payoutoutApprovedByOwner;
  bool public payoutoutApprovedByCoordinator;

  constructor (string memory _symbol, string memory _name) RBACWithAdmin() public {
    symbol = _symbol;
    name = _name;
  }

  function approvePolicy() public {
    approved = true;
  }
}
