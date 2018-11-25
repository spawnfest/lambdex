import React, {Component} from 'react';
import LambdaListItem from "./Home/LambdaListItem";
import Section from "react-bulma-components/lib/components/section";
import client from "../../services/apiClient";

class Home extends Component {
  constructor(props){
    super(props);
    this.state = {data: []};

    client.get("/api/lambdas").then((ret) => {
      console.log(ret.data);
      this.setState({data: ret.data.data});
    });
  }

  render() {
    const itemClicked = (lambda) => {
      alert(lambda.name);
    };

    return <Section>
      {this.state.data.map((lambda, i) => <LambdaListItem key={i} name={lambda.name}
                                               onItemClicked={itemClicked.bind(this, lambda)}/>)}
    </Section>
  }
}


export default Home