import React, {Fragment} from 'react';
import Home from "./components/pages/Home";
import {Route, BrowserRouter as Router} from "react-router-dom";
import Login from "./components/pages/Login";

const AppRouter = () => (
  <Router>
    <Fragment>
      <Route path="/" exact component={Home}/>
      <Route path="/login/" component={Login}/>
    </Fragment>
  </Router>
);

export default AppRouter