import React, { useEffect } from 'react';
import logo from './logo.svg';
import './App.css';
import { connectWallet, initialize } from './ethereum/web3';
import contractLottery from "./ethereum/abis/Lottery.json"

function App() {

  useEffect(() => {
    //@ts-ignore
    if(window.web3) {
      initialize()
    }
  },[])

  const loadBlockChainData = async ()=> {
    //@ts-ignore
    const Web3 = window.web3
    const networkData = contractLottery.networks['5777']
    console.log("Network Data: ",networkData)

    if(networkData){
      const abi = contractLottery.abi
      const address = networkData.address
      console.log('address: ', address)
      const contractDeployed = new Web3.eth.Contract(abi,address)

      const players = await contractDeployed.methods.getPlayers().call();
      console.log("players: ",players)

    }
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
        Truffle, Firebase, React
        </p>
        <button onClick={()=>connectWallet()}>Connect</button>
        <button onClick={()=>loadBlockChainData()}>Load</button>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Truffle, Firebase, React
        </a>
      </header>
    </div>
  );



}

export default App;
