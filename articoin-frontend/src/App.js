import React from 'react';
import ArtworkSubmissionForm from './components/ArtworkSubmissionForm';
import WalletConnection from './components/WalletConnection';

function App() {
  return (
    <div>
      <h1>Articoin</h1>
      <WalletConnection />
      <ArtworkSubmissionForm />
    </div>
  );
}

export default App;
