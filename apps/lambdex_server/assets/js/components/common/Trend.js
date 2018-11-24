import React from 'react';
import "./Trend.scss";
import Icon from "react-bulma-components/lib/components/icon";

const Trend = ({text, number, arrowIcon}) => (
  <div className={"trend"}>
    <span className={"trend-text"}>{text}</span>
    <span className={"trend-number"}>{number} <Icon icon={arrowIcon}/></span>
  </div>
);

export default Trend