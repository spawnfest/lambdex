import React from 'react';
import {Box} from "react-bulma-components";
import Columns from "react-bulma-components/lib/components/columns";
import Heading from "react-bulma-components/lib/components/heading";
import Button from "react-bulma-components/lib/components/button";
import Icon from "react-bulma-components/lib/components/icon";
import './LambdaListItem.scss';
import Trend from "../../common/Trend";

const LambdaListItem = ({name, onItemClicked})=>(
  <Box>
    <Columns>
      <Columns.Column>
        <Heading size={4}>{name}</Heading>
      </Columns.Column>
      <Columns.Column>
        <div className="chart">TEST</div>
        <Trend text="last hour" number={5} arrowIcon="angle-down"/>
      </Columns.Column>
      <Columns.Column>
        <div className="chart">TEST</div>
      </Columns.Column>
      <Columns.Column>
        <Button.Group>
          <Button color="info" onClick={onItemClicked}><Icon icon="edit"/></Button>
          <Button color="info"><Icon icon="edit"/></Button>
          <Button color="info"><Icon icon="edit"/></Button>
          <Button color="info"><Icon icon="cross"/></Button>
        </Button.Group>
      </Columns.Column>
    </Columns>
    </Box>
);


export default LambdaListItem