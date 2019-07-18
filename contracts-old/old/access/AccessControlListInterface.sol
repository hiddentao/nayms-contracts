pragma solidity >=0.5.8;

contract AccessControlListInterface {
  // checking roles in a given context
  function hasRole(bytes32 _context, address _addr, bytes32 _role) view external returns (bool);
  function hasAnyRole(bytes32 _context, address _addr, bytes32[] memory _roles) view external returns (bool);

  // assigning and unassigning roles in a given context
  function assignRole(bytes32 _context, address _addr, bytes32 _role) external;
  function unassignRole(bytes32 _context, address _addr, bytes32 _role) external;

  // setting who can and cannot assign roles in agiven context
  function setCanAssignRole(bytes32 _context, address _addr, bytes32 _role) external;
  function unsetCanAssignRole(bytes32 _context, address _addr, bytes32 _role) external;
  function canAssignRole(bytes32 _context, address _addr, bytes32 _role) view external returns (bool);

  // admins
  function isAdmin(address _addr) view external returns (bool);
  function proposeNewAdmin(address _addr) external;
  function removeAdmin(address _addr) external;
  function acceptAdminRole() external;
}
