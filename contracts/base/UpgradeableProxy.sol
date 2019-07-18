pragma solidity >=0.5.8;

import "./EternalStorage.sol";


/*
TODO: what do we need in an upgradeable contract?

* ability to get owner to opt-in to allow upgrades
* ability to get/set implementation, protected by admin access
* ability to delegate all calls to implementation

Based on https://github.com/zeppelinos/labs/blob/master/upgradeability_using_eternal_storage/contracts
*/
contract UpgradeableProxy is EternalStorage {
  /**
  * @dev This event will be emitted every time the implementation gets upgraded
  * @param implementation representing the address of the upgraded implementation
  */
  event Upgraded(address indexed implementation);

  /**
   * Constructor.
   */
  constructor (address _implementation) public {
    require(_implementation != address(0), 'implementation must be valid');
    dataAddress["implementation"] = _implementation;
  }

  /**
  * @dev Get the address of the implementation where every call will be delegated.
  * @return address of the implementation to which it will be delegated
  */
  function implementation() public view returns (address) {
    return dataAddress["implementation"];
  }

  /**
   * @dev Point to a new implementation.
   * This is internal so that descendants can control access to this in custom ways.
   */
  function setImplementation(address _implementation) internal {
    require(_implementation != address(0), 'implementation must be valid');
    require(_implementation != dataAddress["implementation"], 'already this implementation');
    dataAddress["implementation"] = _implementation;
    emit Upgraded(_implementation);
  }

  /**
  * @dev Fallback function allowing to perform a delegatecall to the given implementation.
  * This function will return whatever the implementation call returns
  */
  function () payable external {
    address _impl = implementation();
    require(_impl != address(0), 'implementation not set');

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
