pragma solidity ^0.5.10;

import "./base/UpgradeableProxy.sol";

contract Policy is UpgradeableProxy {
  constructor (address _policyImpl, string memory _name) UpgradeableProxy(_policyImpl) public {
    dataString["name"] = _name;
  }
}
