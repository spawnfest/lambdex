import React, {Component} from 'react';
import LambdaListItem from "./Home/LambdaListItem";
import Box from "react-bulma-components/lib/components/box";
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Heading from "react-bulma-components/lib/components/heading";
import Button from "react-bulma-components/lib/components/button";
import client from "../../services/apiClient";
import PageLoader from "../common/PageLoader";
import RunLambdaModal from "../common/RunLambdaModal";

class Home extends Component {
  constructor(props) {
    super(props);
    this.state = {data: null};

    this.loadData();
  }

  loadData(){
    client.get("/api/lambdas").then((ret) => {
      this.setState({data: ret.data.data});
    });
  }

  editClicked(lambda) {
    window.location = `/edit/${lambda.id}`;
  }
  
  deleteClicked(lambda) {
    if (confirm("Are you sure you want to delete?")) {
      client.delete(`/api/lambdas/${lambda.id}`).then((ret) => {
        console.log(ret);
        window.location = "/";
      });
    }
  }

  detailsClicked(lambda) {
    window.location = `/details/${lambda.id}`;
  }

  createClicked() {
    window.location = "/create";
  }

  onNewData(){
    this.setState({data: null});
    this.loadData();
  }

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
        <Button color="success" onClick={this.createClicked}>Create</Button>
      </Columns.Column>
    </Columns>
    </Box>
  }

  render() {
    if (this.state.data == null) {
      return <PageLoader/>
    }
    return <Section>
      {this.renderHeader()}
      {this.state.data.map((lambda, i) => <LambdaListItem key={i} lambda={lambda}
                                                          onItemDetails={this.detailsClicked.bind(this, lambda)}
                                                          onItemEdit={this.editClicked.bind(this, lambda)}
                                                          onItemDelete={this.deleteClicked.bind(this, lambda)}
                                                          onNewData={this.onNewData.bind(this)}/>)}
    </Section>
  }
}


export default Home