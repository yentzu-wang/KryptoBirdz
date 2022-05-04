const { assert } = require("chai")
const KryptoBirdz = artifacts.require("KryptoBirdz")

// check for chai
require("chai").use(require("chai-as-promised")).should()

contract("KryptoBirdz", async (accounts) => {
  let contract

  describe("deployment", async () => {
    it("contract is deployed", async () => {
      contract = await KryptoBirdz.deployed()
      const address = contract.address

      assert.notEqual(address, "")
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
      assert.notEqual(address, 0x0)
    })

    it("has a name", async () => {
      const name = await contract.name()
      assert.equal(name, "KryptoBirdz")
    })

    it("has a symbol", async () => {
      const symbol = await contract.symbol()
      assert.equal(symbol, "KBIRDZ")
    })
  })
})
