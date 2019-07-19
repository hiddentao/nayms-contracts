pragma solidity >=0.5.8;

import "./base/AccessControl.sol";
import "./base/UpgradeableProxy.sol";

contract Policy is AccessControl, UpgradeableProxy {
  constructor (address _acl, string memory _aclContext, address _policyImpl, string memory _name) AccessControl(_acl, _aclContext) UpgradeableProxy(_policyImpl) public {
    dataString["name"] = _name;
  }

  function upgrade (address _implementation) isAssetManager public {
    setImplementation(_implementation);
  }
}
