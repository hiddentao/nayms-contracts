pragma solidity >=0.5.8;

interface SystemInterface {
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
  ) external returns (address);
/*
  function naymApplied(address theAddress) public view returns(bool)
  function brokerApplied(address theAddress) public view returns(bool)
  function approvePolicy (address payable policyAddress) public for_owner {
  function isPolicyApproved (address policyAddress) public view returns (bool){
  function getAllPolicies() public view returns (address[] memory) {
  function getPolicyCount() public view returns (uint256) {
  function getAllEntities() public view returns (address[] memory) {
  function getEntity(uint index) public view returns (address) {
  function getEntityCount() public view returns (uint256) {
  function enableYourWallet () public{
  function enableWallet (address theAddress) public returns (address){
  function addWalletAddress(address payable newWalletAddress) public{
  function removeWalletAddress(address payable walletAddress) public for_owner{
  function getEntityAddress() public view returns(address payable) {
  function getEntityAddress(address payable walletAddress) public view returns(address payable) {
  function approveNaym (address entityAddress) public for_owner {
  function approveBroker (address entityAddress) public for_owner {
  function walletEnabled (address theAddress) public view returns (bool) {
  function naymApproved (address entiyAddress) public view returns (bool) {
  function brokerApproved (address entityAddress) public view returns (bool) {
  function walletEnabled ()  public view returns (bool) {
  function applyForNaym () public{
  function applyForBroker () public{
*/
}
