pragma solidity >=0.5.8;

import "./ACLInterface.sol";

contract AccessControl {
  ACLInterface acl;
  bytes32 aclContext;

  constructor (ACLInterface _acl, bytes32 _aclContext) public {
    acl = _acl;
    if (_aclContext == "00000000000000000000000000000000") {
      _aclContext = keccak256(abi.encode(address(this)));
    }
    aclContext = _aclContext;
  }

  modifier isAdmin () {
    require(acl.hasAdminRole(msg.sender));
    _;
  }
}
