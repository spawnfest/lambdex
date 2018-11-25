import React from "react";
import Icon from "react-bulma-components/lib/components/icon";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

const FAIcon = ({icon, ...props}) => {
  return <Icon {...props}>
    <FontAwesomeIcon icon={icon}/>
  </Icon>
};

export default FAIcon;