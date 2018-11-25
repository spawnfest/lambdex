import React from 'react';
import Loader from "react-bulma-components/lib/components/loader";
import Section from "react-bulma-components/lib/components/section";

const PageLoader = () => (
  <Section>
    <Loader style={{width: 50,height: 50, margin: "0 auto"}}/>
  </Section>
);

export default PageLoader;