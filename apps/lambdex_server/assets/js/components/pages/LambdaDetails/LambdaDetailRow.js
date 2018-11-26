import React, {Component} from 'react';
import moment from "moment";
import Button from "react-bulma-components/lib/components/button";

class LambdaDetailRow extends Component {
  render() {
    return <tr>
        <td>{moment.unix(this.props.execution.data["executed_at"]).fromNow()}</td>
        <td>{this.props.execution.data.duration} ms</td>
        <td>
          <Button.Group>
            <Button color="info" onClick={this.props.modalShow(this.props.execution.params)}>params</Button>
            <Button color="info" onClick={this.props.modalShow(this.props.execution.result)}>result</Button>
          </Button.Group>
        </td>
      </tr>
  }
}

export default LambdaDetailRow;