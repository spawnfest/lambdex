import React from 'react';
import "./LambdaDetailsChart.scss";
import {LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip} from "recharts";

const LambdaDetailsChart = ({data, dataKey}) => (
  <div className={"lambda-details-chart"}>
    <LineChart width={250} height={150} data={data}>
      <Line type="monotone" dataKey={dataKey} stroke="#8884d8" strokeWidth={2} activeDot={{r: 8}}/>
      <XAxis dataKey="name"/>
       <YAxis/>
       <CartesianGrid strokeDasharray="3 3"/>
       <Tooltip/>
    </LineChart>
  </div>
);

export default LambdaDetailsChart