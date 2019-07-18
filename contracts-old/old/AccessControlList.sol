pragma solidity >=0.5.8;

import "./lib/Roles.sol";
import "./access/AccessControlListInterface.sol";

contract AccessControlList is AccessControlListInterface {
  using Roles for Roles.Context;

  mapping (bytes32 => Roles.Context) private assignments;
  mapping (bytes32 => Roles.Context) private managers;

  mapping (address => bool) private admins;
  mapping (address => bool) private pendingAdmins;
  uint256 numAdmins;

  event RoleAssigned(bytes32 _context, address _addr, bytes32 _role);
  event RoleUnassigned(bytes32 _context, address _addr, bytes32 _role);

  modifier isAdmin () {
    require(admins[msg.sender]);
    _;
  }

  modifier isAuthorizedToAssign (bytes32 _context, bytes32 _role) {
    // either they have the permission to assign or they're an admin
    require(canAssignRole(_context, msg.sender, _role) || hasAdminRole(msg.sender));
    _;
  }

  constructor () {
    admins[msg.sender] = true;
    numAdmins = 1;
  }

  /**
   * @dev determine if addr is an admin
   */
  function hasAdminRole(address _addr)
    view
    public
    returns (bool)
  {
    return admins[_addr];
  }

  /**
   * @dev determine if addr has role
   */
  function hasRole(bytes32 _context, address _addr, bytes32 _role)
    view
    public
    returns (bool)
  {
    // either they have the role or they're an admin
    return assignments[_context].has(_role, _addr) || admins[_addr];
  }

  function hasAnyRole(bytes32 _context, address _addr, bytes32[] memory _roles)
    view
    public
    returns (bool)
  {
    if (hasRole(_context, _addr, ROLE_ADMIN)) {
      true
    }

    bool hasAnyRole = false;

    for (uint8 i = 0; i < _roles.length; i++) {
      if (hasRole(_context, _addr, _roles[i])) {
        hasAnyRole = true;
        break;
      }
    }

    return hasAnyRole;
  }

  function isAdmin(address _addr) view public {
    return admins[_addr];
  }

  function proposeNewAdmin(address _addr) isAdmin public {
    require(!admins[_addr], 'already an admin');
    requrie(!pendingAdmins[_addr], 'already proposed as an admin')
    pendingAdmins[_addr] = true;
  }

  function removeAdmin(address _addr) isAdmin public {
    requrie(_addr != msg.sender, 'cannot remove yourself');
    requrie(1 < numAdmins, 'cannot remove only admin left');
    proposedAdmins[_addr] = false;
    admins[_addr] = false;
    numAdmins--;
  }

  function acceptAdminRole() public {
    require(pendingAdmins[msg.sender]);
    pendingAdmins[msg.sender] = false;
    admins[msg.sender] = true;
    numAdmins++;
  }

  /**
   * @dev assign a role to an address
   */
  function assignRole(bytes32 _context, address _addr, bytes32 _role)
    isAuthorizedToAssign(_context, _role)
    public
  {
    assignments[_context].add(_role, _addr);
    emit RoleAssigned(_context, _addr, _role);
  }

  /**
   * @dev remove a role from an address
   */
  function removeRole(bytes32 _context, address _addr, bytes32 _role)
    isAuthorizedToAssign(_context, _role)
    public
  {
    assignments[_context].remove(_role, _addr);
    emit RoleUnassigned(_context, _addr, _role);
  }

  function setCanAssignRole(bytes32 _context, address _addr, bytes32 _role)
    isAdmin
    public
  {
    managers[_context].add(_role, _addr);
  }

  function unsetCanAssignRole(bytes32 _context, address _addr, bytes32 _role)
    isAdmin
    public
  {
    managers[_context].add(_role, _addr);
  }

  function canAssignRole(bytes32 _context, address _addr, bytes32 _role) view public returns (bool) {
    return managers[_context].has(_role, _addr);
  }
}
