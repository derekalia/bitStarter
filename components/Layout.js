import React from 'react';
import Header from './Header';
import { Container } from 'semantic-ui-react';
import Head from 'next/head';


export default props => {
  return (
    <Container>
      <Head>
        <link
          rel="stylesheet"
          type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.css"
        />
      </Head>
      <Header />

      {props.children}
      <h1>I'm a footer</h1>
    </Container>
  );
};
