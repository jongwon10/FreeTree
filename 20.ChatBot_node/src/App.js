import React, { Component } from 'react';
import './App.css';
import Aitree from './Aitree';

class App extends Component {
  render() {
    return (
      <div className="App">
        {/* Aitree 컴포넌트를 불러와서 렌더링 */}
        <Aitree />
      </div>
    );
  }
}

export default App;