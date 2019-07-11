pragma solidity ^0.5.10;

import "../access/AccessControl";
import "../access/AccessControlListInterface";


/*
TODO: what do we need in an upgradeable contract?

* ability to get/set implementation, protected by admin access
* ability to delegate all calls to implementation
 */

/*
Based on https://github.com/zeppelinos/labs/blob/master/upgradeability_using_eternal_storage/contracts
 */
contract UpgradeableProxyBase is AccessControl {
  /**
   * @dev The current implementation this proxy points to
   * @type {[type]}
   */
  address private impl;

  /**
  * @dev This event will be emitted every time the implementation gets upgraded
  * @param version representing the version name of the upgraded implementation
  * @param implementation representing the address of the upgraded implementation
  */
  event Upgraded(address indexed implementation);

  /**
   * @dev Construtor.
   * @param _acl the access control list to use
   */
  function constructor (AccessControlListInterface _acl) AccessControl(_acl) {}

  /**
  * @dev Get the address of the implementation where every call will be delegated.
  * @return address of the implementation to which it will be delegated
  */
  function implementation() public view returns (address) {
    return impl;
  }

  /**
   * @dev Point to a new implementation.
   * @param  address the new implementation.
   */
  function setImplementation(address _implementation) isAdmin external {
    require(_implementation != impl, 'already this implementation');
    impl = _implementation;
    Upgraded(_implementation);
  }

  /**
  * @dev Fallback function allowing to perform a delegatecall to the given implementation.
  * This function will return whatever the implementation call returns
  */
  function () payable public {
    address _impl = implementation();
    require(_impl != address(0));

    assembly {
      let ptr := mload(0x40)
      calldatacopy(ptr, 0, calldatasize)
      let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
      let size := returndatasize
      returndatacopy(ptr, 0, size)

      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }
}
