pragma solidity ^0.5.10;

import "../access/RBAC.sol";

/**
 * @title Destructible
 * @dev Base contract that can be destroyed by owner. All funds in contract will be sent to the owner.
 */
contract Destructible is RBAC {
  /**
   * @dev Transfers the current balance to the owner and terminates the contract.
   */
  function destroy() onlyAdmin public {
    selfdestruct(msg.sender);
  }
}
