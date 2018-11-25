import React, {Component} from 'react';
import Box from "react-bulma-components/lib/components/box";
import Columns from "react-bulma-components/lib/components/columns";
import Heading from "react-bulma-components/lib/components/heading";
import Button from "react-bulma-components/lib/components/button";
import './LambdaListItem.scss';
import LambdaListChart from "./LambdaListChart";
import Trend from "../../common/Trend";
import FAIcon from "../../common/FAIcon";
import {faCogs, faInfo, faRunning, faTrash} from "@fortawesome/free-solid-svg-icons";
import RunLambdaModal from "../../common/RunLambdaModal";

class LambdaListItem extends Component {
  constructor(props) {
    super(props);
    this.state = {showModal: false}
  }

  onRunClicked(lambda) {
    this.setState({showModal: true})
  }

  onModalClose() {
    this.setState({showModal: false})
  }

  render() {
    let {lambda, onItemEdit, onItemDetails, onItemDelete} = this.props;

    return (
      <Box>
        <Columns>
          <Columns.Column>
            <Heading size={4} className="lambda-name" onClick={onItemDetails}>{lambda.name}</Heading>
            <div className="lambda-path">/{lambda.path}</div>
          </Columns.Column>
          <Columns.Column>
            <LambdaListChart data={lambda.executions} dataKey={"count"}/>
            <Trend text="last hour" number={5} arrowIcon="angle-down"/>
          </Columns.Column>
          <Columns.Column>
            <LambdaListChart data={lambda.durations} dataKey={"duration"}/>
          </Columns.Column>
          <Columns.Column>
            <Button.Group>
              <Button color="info" onClick={onItemDetails}><FAIcon icon={faInfo}/></Button>
              <Button color="info" onClick={onItemEdit}><FAIcon icon={faCogs}/></Button>
              <Button color="info" onClick={this.onRunClicked.bind(this, lambda)}><FAIcon icon={faRunning}/></Button>
              <Button color="danger" onClick={onItemDelete}><FAIcon icon={faTrash}/></Button>
            </Button.Group>
          </Columns.Column>
        </Columns>
        <RunLambdaModal lambda={lambda}
                        show={this.state.showModal}
                        onClose={this.onModalClose.bind(this)}/>
      </Box>
    );
  }
}

export default LambdaListItem