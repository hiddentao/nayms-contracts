pragma solidity ^0.5.10;

import "./access/RBAC.sol";
import "./StorageInterface.sol";
import "./PolicyInterface.sol";

/**
 * TODO: Implement ERC-223/ERC-20 for shares so that they can be transferred
 */
contract Policy is RBAC, PolicyInterface {
  bool approved;
  string symbol;
  string name;

  uint32 public yieldBasisPoints;
  uint32 public numberOfShares;
  uint256 public startDate;
  uint256 public endDate;
  bool public payoutApprovedByOwner;
  bool public payoutApprovedByCoordinator;

  modifier isBroker () {
    require(hasAnyRole(msg.sender, [ROLE_ADMIN]));
    _;
  }

  constructor (string memory _symbol, string memory _name) RBAC() public {
    symbol = _symbol;
    name = _name;
  }

  function approvePolicy() isPolicyOwner public {
    approved = true;
  }
}
