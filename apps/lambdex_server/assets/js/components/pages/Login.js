import React, {Component} from 'react';
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Container from "react-bulma-components/lib/components/container";
import Box from "react-bulma-components/lib/components/box";

import {Field, Input, Control} from "react-bulma-components/lib/components/form";
import Button from "react-bulma-components/lib/components/button";
import client from "../../services/apiClient";

class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: "",
      password: ""
    };
    this.onEmailChange = this.onEmailChange.bind(this);
    this.onPasswordChange = this.onPasswordChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  onSubmit() {
    client.post("/api/users/token", {
      "data": {
        email: this.state.email,
        password: this.state.password
      }
    }).then((res) => {
      localStorage.setItem("jwt", res.data.token);
      window.location = "/";
    }).catch((err) => {
      if (err && err.response && err.response.status === 400) {
        alert("Wrong username or password.");
      } else if (err && err.response && err.response.data) {
        alert(err.response.data);
      } else {
        alert("Unknown error!");
      }
    });
  }

  onEmailChange(e) {
    this.setState({email: e.target.value})
  }

  onPasswordChange(e) {
    this.setState({password: e.target.value})
  }

  render() {

    return <Section>
      <Container>
        <Columns>
          <Columns.Column size={4} offset={4}>
            <Box>
              <Field>
                <Control>
                  <Input type="text" placeholder="email" value={this.state.email}
                        onChange={this.onEmailChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Input type="password" placeholder="password" value={this.state.password}
                        onChange={this.onPasswordChange}/>
                </Control>
              </Field>
              <Button color={"info"} fullwidth size={"large"} onClick={this.onSubmit}>Login</Button>
            </Box>
          </Columns.Column>
        </Columns>
      </Container>
    </Section>
  }
}


export default Login