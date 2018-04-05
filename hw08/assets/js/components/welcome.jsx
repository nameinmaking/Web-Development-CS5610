import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row, Col } from 'reactstrap';

import UserRegistration from './user-registration';
export default function NoSession(props) {
  function register()
  {
    $("#user-registration").show();
    $("#welcome").hide();
  }

  return (
    <div>
      <Row>
        <Col md="2"></Col>
        <Col md="8">
          <Route path="/" exact={true} render={() =>
            <UserRegistration />
          } />
        </Col>
        <Col md="2"></Col>
      </Row>
      <div id="welcome">
        <p>
          <h2>
          <span id="login">
            &nbsp; <b>Log in</b> to see your tasks. &nbsp;<br />
          </span>

          or<br /> Register <a href="javascript:void(0)"
          onClick={register}>
          <span id="register">
            here
          </span></a>.
        </h2>
        </p>
      </div>
    </div>
  );
}
