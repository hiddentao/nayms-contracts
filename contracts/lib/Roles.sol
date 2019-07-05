pragma solidity ^0.5.10;


/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  struct RoleContext {
    mapping (bytes32 => Role) roles;
  }

  /**
   * @dev give an address access to this role
   */
  function add(RoleContext storage _context, bytes32 _role, address _addr)
    internal
  {
    _context.roles[_role].bearer[_addr] = true
  }

  /**
   * @dev remove an address' access to this role
   */
  function remove(RoleContext storage _role, bytes32 _role, address _addr)
    internal
  {
    _context.roles[_role].bearer[_addr] = false
  }

  /**
   * @dev check if an address has this role
   * @return bool
   */
  function has(RoleContext storage _role, bytes32 _role, address _addr)
    view
    internal
    returns (bool)
  {
    return _context.roles[_role].bearer[_addr]
  }
}
