pragma solidity >=0.5.8;

import "./EternalStorage.sol";
import "./ACLInterface.sol";

contract AccessControl is EternalStorage {
  constructor (address _acl, string memory _aclContext) public {
    dataAddress["acl"] = _acl;
    dataString["aclContext"] = _aclContext;
    dataBytes32["roleAssetManagerAgent"] = keccak256("roleAssetManagerAgent");
    dataBytes32["roleAssetManager"] = keccak256("roleAssetManager");
  }

  modifier isAdmin () {
    require(acl().hasAdminRole(msg.sender));
    _;
  }

  modifier isAssetManagerAgent () {
    bytes32[] memory r = new bytes32[](2);
    r[0] = dataBytes32["roleAssetManagerAgent"];
    r[1] = dataBytes32["roleAssetManager"];
    require(acl().hasAnyRole(dataString["aclContext"], msg.sender, r));
    _;
  }

  modifier isAssetManager () {
    require(acl().hasRole(dataString["aclContext"], msg.sender, dataBytes32["roleAssetManager"]));
    _;
  }

  function acl () view internal returns (ACLInterface) {
    return ACLInterface(dataAddress["acl"]);
  }
}
