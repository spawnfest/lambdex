import React, {Component} from 'react';
import LambdaListItem from "./Home/LambdaListItem";
import Section from "react-bulma-components/lib/components/section";
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

  render() {
    return <Section>
      {this.state.data.map((lambda, i) => <LambdaListItem key={i} lambda={lambda}
                                                          onItemEdit={this.editClicked.bind(this, lambda)}/>)}
    </Section>
  }
}


export default Home