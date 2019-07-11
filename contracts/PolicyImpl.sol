pragma solidity ^0.5.10;

import "./base/EternalStorage.sol";

/**
 * @dev Business-logic for Policy
 */
contract PolicyImpl is EternalStorage {
  /**
   * Approve the policy
   */
  function approve () public {
    dataBool["approved"] = true;
  }

  /**
   * Set the name
   */
  function setName (string memory _name) public {
    dataString["name"] = _name;
  }
}
