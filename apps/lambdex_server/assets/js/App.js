import React, {Component} from 'react';
import Navbar from "react-bulma-components/lib/components/navbar";
import AppRouter from "./AppRouter";

class App extends Component {
  render() {
    const logout = () => {
      localStorage.clear();
      window.location = "/login";
    };

    return (
      <div>
        <Navbar color="light" fixed="top" active>
          <Navbar.Brand>
            <Navbar.Item renderAs="h1" href="#">
              lambdex
            </Navbar.Item>
          </Navbar.Brand>
          <Navbar.Menu>
            <Navbar.Container position="end">
              <Navbar.Item onClick={logout}>
                Logout
              </Navbar.Item>
            </Navbar.Container>
          </Navbar.Menu>
        </Navbar>
        <AppRouter/>
      </div>
    );
  }
}

export default App;
