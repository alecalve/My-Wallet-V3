proxyquire = require('proxyquireify')(require)

WalletCrypto = {}
Bitcoin = {}
BlockchainAPI = {}
MyWallet = {wallet: {defaultPbkdf2Iterations: 5000}}

stubs = {
          './wallet-crypto'  : WalletCrypto
        , 'bitcoinjs-lib'    : Bitcoin
        , './blockchain-api' : BlockchainAPI
        , './wallet' : MyWallet
      }

Signup = proxyquire('../src/wallet-signup', stubs)
BigInteger = require('bigi')

describe "Signup", ->
  beforeEach ->
    spyOn(Signup, "insertWallet").and.callFake(() ->)

  describe "generateNewWallet", ->
    it "should obtain a guid and shared key", ->
      spyOn(WalletCrypto, "xpubToGuid").and.returnValue("")
      Signup.generateNewWallet("a", "password", "info@blockchain.com", "Account name", (()->),(()->), true)
      expect(WalletCrypto.xpubToGuid).toHaveBeenCalled()
