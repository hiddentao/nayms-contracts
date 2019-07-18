pragma solidity >=0.5.8;

contract EternalStorage {
  // scalars
  mapping(string => address) dataAddress;
  mapping(string => string) dataString;
  mapping(string => bytes32) dataBytes32;
  mapping(string => uint256) dataUint256;
  mapping(string => bool) dataBool;
  // arrays
  mapping(string => address[]) dataManyAddress;
  mapping(string => bytes32[]) dataManyBytes32s;
  mapping(string => uint256[]) dataManyUint256;
  mapping(string => bool[]) dataManyBool;
}
