import React, {Fragment} from 'react';
import Home from "./components/pages/Home";
import {Route, BrowserRouter as Router} from "react-router-dom";
import Login from "./components/pages/Login";
import LambdaDetails from "./components/pages/LambdaDetails";

const AppRouter = () => (
  <Router>
    <Fragment>
      <Route path="/" exact component={Home}/>
      <Route path="/login/" component={Login}/>
      <Route path="/details/" component={LambdaDetails}/>
    </Fragment>
  </Router>
);

export default AppRouter