pragma solidity ^0.5.10;

import "./access/AccessControlListInterface.sol";
import "./access/AccessControl.sol";
import "./StorageInterface.sol";

contract Storage is StorageInterface, AccessControl {
  bytes32 public constant AC_ROLE_WRITER = keccak256("writer");

  struct Data {
    mapping(bytes32 => address) singleAddress;
    mapping(bytes32 => string) singleString;
    mapping(bytes32 => bytes32) singleBytes32;
    mapping(bytes32 => uint256) singleUint256;
    mapping(bytes32 => bool) singleBool;

    mapping(bytes32 => address[]) multipleAddress;
    mapping(bytes32 => bytes32[]) multipleBytes32;
    mapping(bytes32 => uint256[]) multipleUint256;
    mapping(bytes32 => bool[]) multipleBool;
  }

  mapping(bytes32 => Data) data;

  modifier isAuthorized () {
    require(acl.hasRole(aclContext, msg.sender, AC_ROLE_WRITER));
    _;
  }

  constructor (AccessControlListInterface _acl) AccessControl(_acl) {}

  // Address

  function getAddress(bytes32 _bucket, bytes32 _key) external view returns (address) {
    return data[_bucket].singleAddress[_key];
  }

  function setAddress(bytes32 _bucket, bytes32 _key, address _value) external isAuthorized {
    data[_bucket].singleAddress[_key] = _value;
  }

  // String

  function getString(bytes32 _bucket, bytes32 _key) external view returns (string memory) {
    return data[_bucket].singleString[_key];
  }

  function setString(bytes32 _bucket, bytes32 _key, string calldata _value) external isAuthorized {
    data[_bucket].singleString[_key] = _value;
  }

  // Uint

  function getUint(bytes32 _bucket, bytes32 _key) external view returns (uint256) {
    return data[_bucket].singleUint256[_key];
  }

  function setUint(bytes32 _bucket, bytes32 _key, uint256 _value) external isAuthorized {
    data[_bucket].singleUint256[_key] = _value;
  }

  // Bool

  function getBool(bytes32 _bucket, bytes32 _key) external view returns (bool) {
    return data[_bucket].singleBool[_key];
  }

  function setBool(bytes32 _bucket, bytes32 _key, bool _value) external isAuthorized {
    data[_bucket].singleBool[_key] = _value;
  }

  // Bytes32

  function getBytes32(bytes32 _bucket, bytes32 _key) external view returns (bytes32) {
    return data[_bucket].singleBytes32[_key];
  }

  function setBytes32(bytes32 _bucket, bytes32 _key, bytes32 _value) external isAuthorized {
    data[_bucket].singleBytes32[_key] = _value;
  }

  // Address[]

  function getAddressList(bytes32 _bucket, bytes32 _key) external view returns (address[] memory) {
    return data[_bucket].multipleAddress[_key];
  }

  function setAddressList(bytes32 _bucket, bytes32 _key, address[] calldata _value, uint256 _len) external isAuthorized {
    data[_bucket].multipleAddress[_key] = _value;
    data[_bucket].multipleAddress[_key].length = _len;
  }

  // Bytes32[]

  function getBytes32List(bytes32 _bucket, bytes32 _key) external view returns (bytes32[] memory) {
    return data[_bucket].multipleBytes32[_key];
  }

  function setBytes32List(bytes32 _bucket, bytes32 _key, bytes32[] calldata _value, uint256 _len) external isAuthorized {
    data[_bucket].multipleBytes32[_key] = _value;
    data[_bucket].multipleBytes32[_key].length = _len;
  }

  // Uint[]

  function getUintList(bytes32 _bucket, bytes32 _key) external view returns (uint256[] memory) {
    return data[_bucket].multipleUint256[_key];
  }

  function setUintList(bytes32 _bucket, bytes32 _key, uint256[] calldata _value, uint256 _len) external isAuthorized {
    data[_bucket].multipleUint256[_key] = _value;
    data[_bucket].multipleUint256[_key].length = _len;
  }

  // Bool[]

  function getBoolList(bytes32 _bucket, bytes32 _key) external view returns (bool[] memory) {
    return data[_bucket].multipleBool[_key];
  }

  function setBoolList(bytes32 _bucket, bytes32 _key, bool[] calldata _value, uint256 _len) external isAuthorized {
    data[_bucket].multipleBool[_key] = _value;
    data[_bucket].multipleBool[_key].length = _len;
  }

  function assignWriterRole(address _addr) external {
    acl.assignRole(aclContext, _addr, ROLE_WRITER);
  }

  function unassignWriterRole(address _addr) external {
    acl.unassignRole(aclContext, _addr, ROLE_WRITER);
  }

  function hasWriterRole(address _addr) view public returns (bool) {
    return acl.hasRole(aclContext, _addr, ROLE_WRITER);
  }

}
