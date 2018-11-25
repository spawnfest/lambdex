import React from 'react';
import "./LambdaListChart.scss";
import {LineChart, Line, Tooltip} from "recharts";

const LambdaListChart = ({data, dataKey}) => (
  <div className={"lambda-list-chart"}>
    <LineChart width={200} height={50} data={data}>
      <Line type="monotone" dataKey={dataKey} stroke="#8884d8" strokeWidth={2} activeDot={{r: 6}} />
      <Tooltip />
    </LineChart>
  </div>
);

export default LambdaListChart