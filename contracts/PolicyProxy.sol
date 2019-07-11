pragma solidity ^0.5.10;

import "./base/UpgradeableProxy.sol";

contract PolicyProxy is UpgradeableProxy {
  constructor (address _implementation, string memory _name) UpgradeableProxy(_implementation) public {
    dataString["name"] = _name;
  }
}
