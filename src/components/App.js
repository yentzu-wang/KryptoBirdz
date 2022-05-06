import React, { useEffect, useState } from "react"
import Web3 from "web3"
import detectEthereumProvider from "@metamask/detect-provider"
import KryptoBirdz from "../abis/KryptoBirdz.json"

const App = () => {
  const [accounts, setAccounts] = useState([])

  useEffect(() => {
    ;(async () => {
      await loadWeb3()
      const accounts = await loadBlockChainData()
      setAccounts(accounts)
    })()
  }, [])

  async function loadWeb3() {
    const provider = await detectEthereumProvider()

    if (provider) {
      console.log("ethereum wallet is connected to " + provider)
      window.web3 = new Web3(provider)
    } else {
      console.log("ethereum wallet is not connected")
    }
  }

  async function loadBlockChainData() {
    const accounts = await window.web3.eth.getAccounts()

    return accounts
  }

  return (
    <div>
      <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 sahdow">
        <div
          className="navbar-brand col-sm-3 col-md-3 mr-0"
          style={{ color: "white" }}
        >
          KryptoBirdz NFTS (Non Fungible Tokens)
        </div>
        <ul className="navbar-nav px-3">
          <li className="nav-item text-nowrap d-none d-sm-none d-sm-block">
            <small className="text-white">{accounts[0]}</small>
          </li>
        </ul>
      </nav>
      <h1>NFT Marketplace</h1>
    </div>
  )
}

export default App
