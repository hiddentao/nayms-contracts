pragma solidity >=0.5.8;

import "./base/EternalStorage.sol";

/**
 * @dev Business-logic for Policy
 */
contract PolicyImpl is EternalStorage {
  /**
   * Set the name
   */
  function setName (string memory _name) public {
    dataString["name"] = _name;
  }
}
