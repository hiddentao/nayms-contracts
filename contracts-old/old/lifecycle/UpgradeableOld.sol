pragma solidity >=0.5.8;

import "./ERC165Interface.sol";
import "../access/AccessControlListInterface.sol";
import "../access/AccessControl.sol";

/*
TODO: look into using proxy pattern for upgradeable contracts.
https://docs.zeppelinos.org/docs/pattern.html

* The proxy wrapper should only store state and provide functions to change the logic contract
* The logic contract should not store any state, and simply provide all needed functions
 */

/*
contract Upgradeable is AccessControl, ERC165Interface {
  bool canUpgrade;
  bytes4 interfaceId;

  constructor (AccessControlListInterface _acl, bytes4 _interfaceId) AccessControl(_acl) public {
    interfaceId = _interfaceId;
  }

  function enableUpgrade() public {
    canUpgrade = true;
  }

  function upgrade(address payable _newContract) isAdmin external {
    if (!canUpgrade) {
      revert("upgrade not enabled yet!")
    }
    ERC165Interface i = ERC165Interface(_newContract);
    require(i.supportsInterface(interfaceId), 'new contract has different interface');
    selfdestruct(_newContract);
  }

  function supportsInterface(bytes4 _interfaceId) external view returns (bool) {
    return _interfaceId == interfaceId;
  }

  // NOTE: we don't need to explicitly specify a payable fallback function
  // since ETH received from a selfdestruct() is always accepted.
  //
  // (see https://solidity.readthedocs.io/en/v0.5.10/contracts.html#fallback-function)
}
*/
