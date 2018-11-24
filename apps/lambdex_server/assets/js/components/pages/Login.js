import React from 'react';
import Section from "react-bulma-components/lib/components/section";
import Columns from "react-bulma-components/lib/components/columns";
import Container from "react-bulma-components/lib/components/container";
import Box from "react-bulma-components/lib/components/box";

import {Field, Input, Control} from "react-bulma-components/lib/components/form";
import Button from "react-bulma-components/lib/components/button";

const Login = () => (
  <Section>
    <Container >
      <Columns>
        <Columns.Column size={4} offset={4}>
          <Box>
            <Field>
              <Control>
                <Input type="text" placeholder="username" />
              </Control>
            </Field>
            <Field>
              <Control>
                <Input type="text" placeholder="password" />
              </Control>
            </Field>
            <Button color={"info"} fullwidth size={"large"}>Login</Button>
          </Box>
        </Columns.Column>
      </Columns>
    </Container>
  </Section>
);


export default Login