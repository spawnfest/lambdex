import React from 'react';
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Panel from "react-bulma-components/lib/components/panel";
import Table from "react-bulma-components/lib/components/table";
import Button from "react-bulma-components/lib/components/button";
import Icon from "react-bulma-components/lib/components/icon";

const data = [
  {ranAt: "01/01/2019 14:30:33", took:"3sec", launchedFrom:"REST"},
  {ranAt: "01/01/2019 14:30:33", took:"3sec", launchedFrom:"REST"},
  {ranAt: "01/01/2019 14:30:33", took:"3sec", launchedFrom:"REST"},
  {ranAt: "01/01/2019 14:30:33", took:"3sec", launchedFrom:"REST"},
];

const LambdaDetails = () => (
  <Section>
    <Columns>
      <Columns.Column>
        <Panel>
          <Panel.Header>Runs</Panel.Header>
          <Panel.Block>
            test
          </Panel.Block>
        </Panel>
      </Columns.Column>
      <Columns.Column>
        <Panel>
          <Panel.Header>Timing</Panel.Header>
          <Panel.Block>
            test
          </Panel.Block>
        </Panel>
      </Columns.Column>
      <Columns.Column>
        <Panel>
          <Panel.Header>Failures</Panel.Header>
          <Panel.Block>
            test
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
          {data.map((item, i)=> (
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


export default LambdaDetails