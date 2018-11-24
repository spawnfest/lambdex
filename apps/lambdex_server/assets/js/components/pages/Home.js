import React from 'react';
import LambdaListItem from "./Home/LambdaListItem";
import Section from "react-bulma-components/lib/components/section";

const data = [
  {name: "Lambda #1"},
  {name: "Lambda #2"},
  {name: "Lambda #3"},
  {name: "Lambda #4"},
  {name: "Lambda #5"},
];

const Home = () => {
  const itemClicked = (lambda) => {
    alert(lambda.name);
  };
  return <Section>
    {data.map((lambda, i)=><LambdaListItem key={i} name={lambda.name} onItemClicked={itemClicked.bind(this, lambda)}/>)}
  </Section>
};


export default Home