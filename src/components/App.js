import React, { useEffect, useReducer } from "react"
import Web3 from "web3"
import detectEthereumProvider from "@metamask/detect-provider"
import KryptoBirdz from "../abis/KryptoBirdz.json"

const App = () => {
  const [state, setState] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      accounts: [],
      contract: null,
      totalSupply: 0,
      kryptoBirdz: [],
    }
  )

  console.log(state)

  useEffect(() => {
    ;(async () => {
      await loadWeb3()
      await loadBlockChainData()
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
    setState({ accounts })

    const networkId = await window.web3.eth.net.getId()
    const netWorkData = KryptoBirdz.networks[networkId]

    if (netWorkData) {
      const abi = KryptoBirdz.abi
      const address = netWorkData.address
      const contract = new window.web3.eth.Contract(abi, address)
      setState({ contract })

      const totalSupply = await contract.methods.totalSupply().call()

      setState({ totalSupply })
      for (let i = 1; i <= totalSupply; i++) {
        const kryptoBird = await contract.methods.kryptoBirdz(i - 1).call()
        setState({ kryptoBirdz: [...state.kryptoBirdz, kryptoBird] })
      }
    } else {
      window.alert("Smart contract not deployed")
    }
  }

  async function mint(kryptoBird) {
    state.contract.methods
      .mint(kryptoBird)
      .send({ from: state.accounts[0] })
      .once("receipt", (receipt) => {
        setState({ kryptoBirdz: [...state.kryptoBirdz, kryptoBird] })
      })
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
            <small className="text-white">{state.accounts[0]}</small>
          </li>
        </ul>
      </nav>
      <div className="container-fluid mt-1">
        <div className="row">
          <main role="main" className="col-lg-12 d-flex text-center">
            <div className="content mr-auto ml-auto" style={{ opacity: "0.8" }}>
              <h1 style={{ color: "white" }}>KryptoBirdz - NFT Marketplace</h1>
            </div>
          </main>
        </div>
      </div>
    </div>
  )
}

export default App
