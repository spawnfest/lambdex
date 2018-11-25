import React, {Component} from 'react';
import Section from "react-bulma-components/lib/components/section";
import PageLoader from "../common/PageLoader";
import LambdaForm from "../common/LambdaForm";
import client from "../../services/apiClient";

class LambdaEdit extends Component {
  constructor(props) {
    super(props);
    this.state = {lambda: null};

    client.get(`/api/lambdas/${props.match.params.id}`).then((ret) => {
      this.setState({lambda: ret.data.data});
    });
  }

  render() {
    if (!this.state.lambda) {
      return <PageLoader/>
    }
    return (
      <Section>
        <LambdaForm lambda={this.state.lambda}/>
      </Section>
    );
  }
}


export default LambdaEdit