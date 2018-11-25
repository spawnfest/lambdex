import React, {Component} from 'react';

import client from "../../services/apiClient";

import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Panel from "react-bulma-components/lib/components/panel";
import Table from "react-bulma-components/lib/components/table";
import Button from "react-bulma-components/lib/components/button";
import Box from "react-bulma-components/lib/components/box";
import Level from "react-bulma-components/lib/components/level";

import LambdaDetailsChart from "./LambdaDetails/LambdaDetailsChart";
import PageLoader from "../common/PageLoader";
import Heading from "react-bulma-components/lib/components/heading";
import FAIcon from "../common/FAIcon";
import {faCogs, faRunning, faTrash} from "@fortawesome/free-solid-svg-icons";
import RunLambdaModal from "../common/RunLambdaModal";
import LambdaDetailRow from "./LambdaDetails/LambdaDetailRow";

class LambdaDetails extends Component {
  constructor(props) {
    super(props);
    this.state = {lambda: null, showModal:false, executions: null};

    client.get(`/api/lambdas/${props.match.params.id}`).then((ret) => {
      this.setState({lambda: ret.data.data})
    });

    client.get(`/api/lambdas/${props.match.params.id}/executions`).then((ret) => {
      this.setState({executions: ret.data.data})
    })
  }

  editClicked() {
    window.location = `/edit/${this.state.lambda.id}`;
  }
  
  deleteClicked() {
    if (confirm("Are you sure you want to delete?")) {
      client.delete(`/api/lambdas/${this.state.lambda.id}`).then((ret) => {
        console.log(ret);
        window.location = "/";
      });
    }
  }
  onRunClicked() {
    this.setState({showModal: true})
  }

  onModalClose() {
    this.setState({showModal: false})
  }
  render() {
    if (!this.state.lambda) {
      return <PageLoader/>
    }
    return (
      <Section>
        <Box>
          <Level>
            <Level.Side align="left">
              <Level.Item className="lambda-detail-title">
                <Heading size={5} subtitle>
                  <strong>{this.state.lambda.name}</strong>
                  <small>/{this.state.lambda.path}</small>
                </Heading>
              </Level.Item>
            </Level.Side>
            <Level.Side align="right">
              <Level.Item><Button color="info" onClick={this.editClicked.bind(this)}><FAIcon icon={faCogs}/></Button></Level.Item>
              <Level.Item><Button color="info" onClick={this.onRunClicked.bind(this)}><FAIcon icon={faRunning}/></Button></Level.Item>
              <Level.Item><Button color="danger" onClick={this.deleteClicked.bind(this)}><FAIcon icon={faTrash}/></Button></Level.Item>
            </Level.Side>
          </Level>
        </Box>
        <Columns>
          <Columns.Column>
            <Panel>
              <Panel.Header>Runs</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={this.state.lambda.executions} dataKey={"count"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
          <Columns.Column>
            <Panel>
              <Panel.Header>Timing</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={this.state.lambda.durations} dataKey={"duration"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
          <Columns.Column>
            <Panel>
              <Panel.Header>Failures</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={this.state.lambda.errors} dataKey={"count"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
        </Columns>
        <Panel>
          <Panel.Header>Last Runs</Panel.Header>
          <Panel.Block>
            {!this.state.executions && <PageLoader/>}
            {this.state.executions && <Table>
              <thead>
              <tr>
                <th>ran at</th>
                <th>took</th>
                <th>show</th>
              </tr>
              </thead>
              <tbody>
              {this.state.executions.map((item, i) => <LambdaDetailRow key={i} execution={item}/>)}
              </tbody>
            </Table>}
          </Panel.Block>
        </Panel>
        <RunLambdaModal lambda={this.state.lambda}
                        show={this.state.showModal}
                        onClose={this.onModalClose.bind(this)}/>
      </Section>
    );
  }
}

export default LambdaDetails