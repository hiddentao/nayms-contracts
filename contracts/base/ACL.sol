pragma solidity >=0.5.8;

import "./ACLRoles.sol";
import "./ACLInterface.sol";

contract ACL is ACLInterface {
  using ACLRoles for ACLRoles.Context;

  mapping (string => ACLRoles.Context) private assignments;
  mapping (string => ACLRoles.Context) private assigners;

  mapping (address => bool) private admins;
  mapping (address => bool) private pendingAdmins;
  uint256 numAdmins;

  event RoleAssigned(string _context, address indexed _addr, bytes32 indexed _role);
  event RoleUnassigned(string _context, address indexed _addr, bytes32 indexed _role);

  modifier isAdmin () {
    require(admins[msg.sender]);
    _;
  }

  modifier isAssigner (string memory _context, bytes32 _role) {
    // either they have the permission to assign or they're an admin
    require(hasAssignerRole(_context, msg.sender, _role) || hasAdminRole(msg.sender));
    _;
  }

  constructor () public {
    admins[msg.sender] = true;
    numAdmins = 1;
  }

  /**
   * @dev determine if addr has role
   */
  function hasRole(string memory _context, address _addr, bytes32 _role)
    view
    public
    returns (bool)
  {
    return assignments[_context].has(_role, _addr);
  }

  function hasAnyRole(string memory _context, address _addr, bytes32[] memory _roles)
    view
    public
    returns (bool)
  {
    bool hasAny = false;

    for (uint8 i = 0; i < _roles.length; i++) {
      if (hasRole(_context, _addr, _roles[i])) {
        hasAny = true;
        break;
      }
    }

    return hasAny;
  }

  /**
   * @dev determine if addr is an admin
   */
  function hasAdminRole(address _addr) view public returns (bool) {
    return admins[_addr];
  }

  function proposeNewAdmin(address _addr) isAdmin public {
    require(!admins[_addr], 'already an admin');
    require(!pendingAdmins[_addr], 'already proposed as an admin');
    pendingAdmins[_addr] = true;
  }

  function removeAdmin(address _addr) isAdmin public {
    require(_addr != msg.sender, 'cannot remove yourself');
    require(1 < numAdmins, 'cannot remove only admin left');
    pendingAdmins[_addr] = false;
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
  function assignRole(string memory _context, address _addr, bytes32 _role)
    isAssigner(_context, _role)
    public
  {
    assignments[_context].add(_role, _addr);
    emit RoleAssigned(_context, _addr, _role);
  }

  /**
   * @dev remove a role from an address
   */
  function removeRole(string memory _context, address _addr, bytes32 _role)
    isAssigner(_context, _role)
    public
  {
    assignments[_context].remove(_role, _addr);
    emit RoleUnassigned(_context, _addr, _role);
  }

  function addAssigner(string memory _context, address _addr, bytes32 _role)
    isAdmin
    public
  {
    assigners[_context].add(_role, _addr);
  }

  function removeAssigner(string memory _context, address _addr, bytes32 _role)
    isAdmin
    public
  {
    assigners[_context].add(_role, _addr);
  }

  function hasAssignerRole(string memory _context, address _addr, bytes32 _role) view public returns (bool) {
    return assigners[_context].has(_role, _addr);
  }
}
