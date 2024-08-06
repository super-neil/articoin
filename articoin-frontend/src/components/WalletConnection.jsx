import React, { useState } from 'react';
import { ethers } from 'ethers';

function WalletConnection() {
    const [isConnected, setIsConnected] = useState(false);
    const [account, setAccount] = useState(null);

    const connectWallet = async () => {
        try {
            if (typeof window.ethereum !== 'undefined') {
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                await provider.send("eth_requestAccounts", []);
                const signer = provider.getSigner();
                const address = await signer.getAddress();

                setIsConnected(true);
                setAccount(address);

                // ... (optional: fetch contract information if needed)
            } else {
                alert("Please install MetaMask!");
            }
        } catch (error) {
            console.error("Error connecting wallet:", error);
            // Add error handling UI (e.g., display an error message)
        }
    };

    return (
        <div>
            {isConnected ? (
                <p>Connected: {account}</p> 
            ) : (
                <button onClick={connectWallet}>Connect Wallet</button>
            )}
        </div>
    );
}

export default WalletConnection;
