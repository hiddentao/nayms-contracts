pragma solidity ^0.5.10;

import "./ACLInterface"

contract AccessControl {
  ACLInterface acl;
  bytes32 aclContext;

  constructor (ACLInterface _acl, bytes32 _aclContext) {
    acl = _acl;
    if (_aclContext == "00000000000000000000000000000000") {
      _aclContext = keccak256(address(this));
    }
    aclContext = _aclContext;
  }

  modifier isAdmin () {
    require(acl.isAdmin(msg.sender));
    _;
  }
}
