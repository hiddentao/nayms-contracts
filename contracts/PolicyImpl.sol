pragma solidity >=0.5.8;

import "./base/AccessControl.sol";
import "./base/EternalStorage.sol";

/**
 * @dev Business-logic for Policy
 */
contract PolicyImpl is EternalStorage, AccessControl {
  /**
   * Set the name
   */
  function setName (string memory _name) isAssetManagerAgent public {
    dataString["name"] = _name;
  }

  /**
   * Approve this policy
   */
  function approve () isAssetManagerAgent public {
    dataBool["approved"] = true;
  }
}
