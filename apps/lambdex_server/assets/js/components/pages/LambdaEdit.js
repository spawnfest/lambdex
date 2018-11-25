import React from 'react';
import Section from "react-bulma-components/lib/components/section";

const LambdaEdit = ({match}) => (
  <Section>
    {match.params.id}
  </Section>
);


export default LambdaEdit