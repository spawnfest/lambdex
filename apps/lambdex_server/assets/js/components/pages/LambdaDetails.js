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

const
  mockDataChart = [
    {hour: 12, runs: 2, timing: 7, failures: 1},
    {hour: 13, runs: 5, timing: 4, failures: 6},
    {hour: 14, runs: 3, timing: 12, failures: 3},
    {hour: 15, runs: 1, timing: 3, failures: 9}
  ],
  mockDataLastRuns = [
    {ranAt: "01/01/2019 14:30:33", took: "3sec", launchedFrom: "REST"},
    {ranAt: "01/01/2019 14:30:33", took: "3sec", launchedFrom: "REST"},
    {ranAt: "01/01/2019 14:30:33", took: "3sec", launchedFrom: "REST"},
    {ranAt: "01/01/2019 14:30:33", took: "3sec", launchedFrom: "REST"},
  ];

class LambdaDetails extends Component {
  constructor(props) {
    super(props);
    this.state = {lambda: null};

    client.get(`/api/lambdas/${props.match.params.id}`).then((ret) => {
      this.setState({lambda: ret.data.data})
    })
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
              <Level.Item><Button color="info"><FAIcon icon={faCogs}/></Button></Level.Item>
              <Level.Item><Button color="info"><FAIcon icon={faRunning}/></Button></Level.Item>
              <Level.Item><Button color="danger"><FAIcon icon={faTrash}/></Button></Level.Item>
            </Level.Side>
          </Level>
        </Box>
        <Columns>
          <Columns.Column>
            <Panel>
              <Panel.Header>Runs</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={mockDataChart} dataKey={"runs"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
          <Columns.Column>
            <Panel>
              <Panel.Header>Timing</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={mockDataChart} dataKey={"timing"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
          <Columns.Column>
            <Panel>
              <Panel.Header>Failures</Panel.Header>
              <Panel.Block>
                <LambdaDetailsChart data={mockDataChart} dataKey={"failures"}/>
              </Panel.Block>
            </Panel>
          </Columns.Column>
        </Columns>
        <Panel>
          <Panel.Header>Last Runs</Panel.Header>
          <Panel.Block>
            <Table>
              <thead>
              <tr>
                <th>ran at</th>
                <th>took</th>
                <th>launched from</th>
                <th>show</th>
              </tr>
              </thead>
              <tbody>
              {mockDataLastRuns.map((item, i) => (
                <tr key={i}>
                  <td>{item.ranAt}</td>
                  <td>{item.took}</td>
                  <td>{item.launchedFrom}</td>
                  <td>
                    <Button.Group>
                      <Button color="info">call info</Button>
                      <Button color="info">params</Button>
                      <Button color="info">output</Button>
                    </Button.Group>
                  </td>
                </tr>
              ))}
              </tbody>
            </Table>
          </Panel.Block>
        </Panel>
      </Section>
    );
  }
}

export default LambdaDetails