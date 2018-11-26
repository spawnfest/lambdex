import React, {Component} from 'react';
import Modal from "react-bulma-components/lib/components/modal";
import {
  Field,
  Control,
  Label,
  Textarea,
} from 'react-bulma-components/lib/components/form';
import Button from 'react-bulma-components/lib/components/button';
import client from "../../services/apiClient";
import PageLoader from "./PageLoader";
import Message from "react-bulma-components/lib/components/message";

class RunLambdaModal extends Component {
  constructor(props) {
    super(props);
    this.state = {
      params: "{}",
      errors: null,
      running: false,
      output: null
    }
  }

  onParamsChange(e){
    this.setState({params: e.target.value})
  }

  onRunClicked(){
    let params = {};
    try {
      params = JSON.parse(this.state.params);
    } catch(e) {
      this.setState({errors: "Invalid JSON"})
      return
    }

    this.setState({running: true, errors: null, output: null});
    client.post(`/api/lambdas/${this.props.lambda.path}`, params)
      .then((data)=>{this.setState({output: JSON.stringify(data.data.data.data, null, 2), running: false})})
      .catch((data)=>{this.setState({errors: "Error running lambda", running: false})})
  }

  render() {
    let {lambda, ...props} = this.props;
    return <Modal {...props}>
      <Modal.Card>
        <Modal.Card.Head onClose={props.onClose}>
          <Modal.Card.Title>Run {lambda.name}</Modal.Card.Title>
        </Modal.Card.Head>
        <Modal.Card.Body>
          <Field>
            <Label>Parameters</Label>
            <Control>
              <Textarea onChange={this.onParamsChange.bind(this)} value={this.state.params} placeholder="Textarea"/>
            </Control>
          </Field>
          {this.state.running && <PageLoader/>}
          {this.state.errors && <Message color="danger"><Message.Body>{this.state.errors}</Message.Body></Message>}
          {this.state.output && <Message color="info">
            <Message.Header>Output</Message.Header>
            <Message.Body><pre>{this.state.output}</pre></Message.Body>
          </Message>}
        </Modal.Card.Body>
        <Modal.Card.Foot style={{alignItems: 'center', justifyContent: 'center'}}>
          <Control>
            <Button color="link" onClick={this.onRunClicked.bind(this)}>Run</Button>
          </Control>
        </Modal.Card.Foot>
      </Modal.Card>
    </Modal>
  }
}

export default RunLambdaModal;