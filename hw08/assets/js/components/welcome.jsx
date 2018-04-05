import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row, Col } from 'reactstrap';

import UserRegistration from './user-registration';
// Renders a message telling the user to log in
export default function NoSession(props) {
  // Toggles the registration form
  function register() {
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
          <span id="login">
            &nbsp; <b>Log in</b> to see your tasks. &nbsp;<br />
          </span>

          or<br /> Register <a href="javascript:void(0)"
          onClick={register}>
          <span id="register">
            here
          </span></a>.
        </p>
      </div>
    </div>
  );
}
