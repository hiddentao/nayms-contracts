pragma solidity ^0.5.10;

interface PolicyInterface {
  enum OrderStatus { OPEN,CLOSED,FILLED,PART_FILLED,CANCELLED }
  enum OrderType { BUY,SELL }

  function approvePolicy() external;
}
