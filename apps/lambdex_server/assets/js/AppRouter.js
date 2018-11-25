import React, {Fragment} from 'react';
import Home from "./components/pages/Home";
import {Route, BrowserRouter as Router} from "react-router-dom";
import Login from "./components/pages/Login";
import LambdaDetails from "./components/pages/LambdaDetails";
import LambdaEdit from "./components/pages/LambdaEdit";

const AppRouter = () => (
  <Router>
    <Fragment>
      <Route path="/" exact component={Home}/>
      <Route path="/login/" component={Login}/>
      <Route path="/details/:id" component={LambdaDetails}/>
      <Route path="/edit/:id" component={LambdaEdit}/>
    </Fragment>
  </Router>
);

export default AppRouter