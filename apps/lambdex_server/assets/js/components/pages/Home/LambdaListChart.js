import React from 'react';
import "./LambdaListChart.scss";
import {LineChart, Line, Tooltip, XAxis} from "recharts";

const LambdaListChart = ({data, dataKey}) => (
  <div className={"lambda-list-chart"}>
    <LineChart width={200} height={100} data={data}>
      <Line animationDuration={0} isAnimationActive={false}
            type="monotone" dataKey={dataKey} stroke="#8884d8" strokeWidth={2} activeDot={{r: 6}} />
      <Tooltip />
      <XAxis hide={true} dataKey="timestamp"/>
    </LineChart>
  </div>
);

export default LambdaListChart