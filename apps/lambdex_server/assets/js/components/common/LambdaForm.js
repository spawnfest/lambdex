import React, {Component} from 'react';
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Container from "react-bulma-components/lib/components/container";
import Box from "react-bulma-components/lib/components/box";

import {Field, Input, Textarea, Control, Checkbox, Label, Help} from "react-bulma-components/lib/components/form";
import Button from "react-bulma-components/lib/components/button";
import client from "../../services/apiClient";

class LambdaForm extends Component {
  constructor(props) {
    super(props);
    
    const lambda = props.lambda || {};
    this.state = {
      name: lambda.name,
      path: lambda.path,
      params: JSON.stringify(lambda.params, 2),
      code: lambda.code,
      enabled: Boolean(lambda.enabled)
    };
    this.method = lambda.id ? "patch" : "post";
    this.submit = lambda.id ? "Update" : "Create";
    this.action = `/api/lambdas${lambda.id ? `/${lambda.id}` : ""}`;
    
    this.handleInputChange = this.handleInputChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  handleInputChange(event) {
    const target = event.target;
    this.setState({
      [target.name]: target.type === "checkbox" ? target.checked : target.value
    });
  }

  validateData(data) {
    const errors = [];

    if (!data.name) {
      errors.push("- Name is required.");
    }
    if (!data.path) {
      errors.push("- Path is required.");
    }
    if (!data.code) {
      errors.push("- Code is required.");
    }
    try {
      JSON.parse(data.params || "{}")
    } catch (e) {
      errors.push("- Params is not a valid JSON string.");
    }

    return errors;
  }

  onSubmit() {
    const errors = this.validateData(this.state);
    if (errors.length) {
      return alert(errors.join("\n"));
    }

    client[this.method](this.action, {
      lambda: {
        name: this.state.name,
        path: this.state.path,
        params: JSON.parse(this.state.params || "{}"),
        code: this.state.code,
        enabled: this.state.enabled
      }
    }).then((res) => {
      console.log(res);
      window.location = "/";
    }).catch((err) => {
      alert(err);
    });
  }

  onCancel() {
    window.location = "/";
  };

  render() {
    return <Section>
      <Container>
        <Columns>
          <Columns.Column size={8} offset={2}>
            <Box>
              <Field>
                <Control>
                  <Label>Name</Label>
                  <Input type="text" name="name" value={this.state.name}
                        onChange={this.handleInputChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Label>Path</Label>
                  <Input type="text" name="path" value={this.state.path}
                        onChange={this.handleInputChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Label>ENV Params</Label>
                  <Help color="info">{'{"key": "val", ...}'}</Help>
                  <Textarea type="text" name="params" value={this.state.params}
                        onChange={this.handleInputChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Label>Code</Label>
                  <Help color="info">fn (environment_variables, _execution_variables) -> ... your code here... end</Help>
                  <Textarea type="text" name="code" value={this.state.code}
                        onChange={this.handleInputChange}/>
                </Control>
              </Field>
              <Field>
                <Control>
                  <Label>Enabled</Label>
                  <Checkbox name="enabled" checked={this.state.enabled}
                        onChange={this.handleInputChange}/>
                </Control>
              </Field>
              <Button color={"success"} size={"large"} onClick={this.onSubmit}>{this.submit}</Button>
              <Button color={"danger"} size={"large"} onClick={this.onCancel}>Cancel</Button>
            </Box>
          </Columns.Column>
        </Columns>
      </Container>
    </Section>
  }
}


export default LambdaForm