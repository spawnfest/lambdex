import React, {Component} from 'react';
import LambdaListItem from "./Home/LambdaListItem";
import Box from "react-bulma-components/lib/components/box";
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Heading from "react-bulma-components/lib/components/heading";
import client from "../../services/apiClient";

class Home extends Component {
  constructor(props) {
    super(props);
    this.state = {data: []};

    client.get("/api/lambdas").then((ret) => {
      this.setState({data: ret.data.data});
    });
  }

  editClicked(lambda) {
    window.location = `/edit/${lambda.id}`;
  };

  renderHeader() {
    return <Box className="lambda-list-header">
    <Columns>
      <Columns.Column>
        <Heading size={4}>Lambda</Heading>
      </Columns.Column>
      <Columns.Column>
        <Heading size={4}># of runs</Heading>
      </Columns.Column>
      <Columns.Column>
        <Heading size={4}>Timing</Heading>
      </Columns.Column>
      <Columns.Column>
      </Columns.Column>
    </Columns>
    </Box>
  }

  render() {
    return <Section>
      {this.renderHeader()}
      {this.state.data.map((lambda, i) => <LambdaListItem key={i} lambda={lambda}
                                                          onItemEdit={this.editClicked.bind(this, lambda)}/>)}
    </Section>
  }
}


export default Home