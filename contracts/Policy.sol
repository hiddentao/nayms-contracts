pragma solidity ^0.5.10;

import "./access/RBACWithAdmin.sol";
import "./StorageInterface.sol";
import "./PolicyInterface.sol";

contract Policy is RBACWithAdmin, PolicyInterface {
  bytes32 public constant ROLE_POLICY_OWNER = keccak256("policy owner");

  bool approved;
  string symbol;
  string name;

  uint32 public yieldBasisPoints;
  uint32 public numberOfShares;
  uint256 public startDate;
  uint256 public endDate;
  bool public payoutoutApprovedByOwner;
  bool public payoutoutApprovedByCoordinator;

  modifier isPolicyOwner () {
    require(hasAnyRole(msg.sender, [ROLE_POLICY_OWNER, ROLE_ADMIN]));
    _;
  }

  constructor (string memory _symbol, string memory _name) RBACWithAdmin() public {
    symbol = _symbol;
    name = _name;
    addRole(msg.sender, ROLE_POLICY_OWNER);
  }

  function approvePolicy() isPolicyOwner public {
    approved = true;
  }
}
