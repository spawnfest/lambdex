import React, {Component} from 'react';
import Navbar from "react-bulma-components/lib/components/navbar";
import AppRouter from "./AppRouter";

class App extends Component {
  render() {
    return (
      <div>
        <Navbar color="light" fixed="top" active>
          <Navbar.Brand>
            <Navbar.Item renderAs="h1" href="#">
              lambdex
            </Navbar.Item>
          </Navbar.Brand>
        </Navbar>
        <AppRouter/>
      </div>
    );
  }
}

export default App;
