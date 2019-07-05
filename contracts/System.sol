pragma solidity ^0.5.10;

import "./lifecycle/Upgradeable.sol";
import "./SystemInterface.sol";

contract System is Upgradeable, SystemInterface {
  constructor () Upgradeable() {
    /*
    TODO: what should this do?
     */
  }

  function createPolicy(
    string memory _symbol,
    string memory _name,
    /* Translates to ERC-20 token count? */
    uint32 _numberOfShares,
    /* TODO: If we use 0x contracts for trading will this still be relevant? */
    uint128 _initialPricePerShare,
    /* TODO: what do these dates determine? */
    uint256 _startDate,
    uint256 _endDate,
    uint32 _yieldBasisPoints
  ) public returns (address) {
    /*
    TODO flesh this out
     */
  }
}
