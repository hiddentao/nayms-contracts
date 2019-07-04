const Storage = require('./build/contracts/Storage.json')

module.exports = {
  Storage,
  events: {
    /* export events here */
    // WriteInt: Storage.abi.find(({ type, name }) => type === 'event' && name === 'WriteInt'),
  }
}
