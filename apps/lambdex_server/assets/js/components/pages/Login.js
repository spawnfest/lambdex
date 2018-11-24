import React, {Component} from 'react';
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Container from "react-bulma-components/lib/components/container";
import Box from "react-bulma-components/lib/components/box";

import {Field, Input, Control} from "react-bulma-components/lib/components/form";
import Button from "react-bulma-components/lib/components/button";

class Login extends Component {
  constructor(props){
    super(props);
    this.state = {
      username: "",
      password: ""
    };
    this.onUsernameChange = this.onUsernameChange.bind(this);
    this.onPasswordChange = this.onPasswordChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }
  onSubmit(){
    alert(this.state.username + " - " + this.state.password);
  }
  onUsernameChange(e){
    this.setState({username: e.target.value})
  }

  onPasswordChange(e){
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
                  <Input type="text" placeholder="username" value={this.state.username} onChange={this.onUsernameChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Input type="password" placeholder="password" value={this.state.password} onChange={this.onPasswordChange}/>
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