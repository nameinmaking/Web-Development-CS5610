import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import api from '../api';

// Renders the registration form
function RegistrationForm(props) {
  // Updates the state with the inputted values from the registration form
  function update(ev) {
    let tgt = $(ev.target);
    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_REGISTRATION_FORM',
      data: data
    };
    props.dispatch(action);
  }

  // Sends a request to create a user with the values from the forms
  function submit(ev) {
    api.create_user(props.form);
  }

  // Clears all of the fields and closes the form
  function cancel() {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
    $("#registration-form").hide();
    $("#no-session").show();
  }

  return (
    <div id="registration-form">
      <div className="p-4 col-md-5 text-right">
        <u><b><h2>Account Registeration Form</h2></b></u>
      </div>

      <div>
        <div className="p-4 text-right">
          <FormGroup className="row">
            <Label for="email" className="col-md-2"><b>Email:</b></Label>
            <Input type="email" name="email" value={props.form.email}
              onChange={update} placeholder="user@example.com" className="col-md-3"/>
          </FormGroup>
          <FormGroup className="row">
            <Label for="name" className="col-md-2"><b>Name:</b></Label>
            <Input type="text" name="name" value={props.form.name}
              onChange={update} className="col-md-3"/>
          </FormGroup>
          <FormGroup className="row">
            <Label for="password" className="col-md-2"><b>Password:</b></Label>
            <Input type="password" name="password" value={props.form.password}
              onChange={update} placeholder="(must be at least 8 characters)" className="col-md-3"/>
          </FormGroup>
        </div>
        <div className="text-right col-md-5">
          <Button onClick={submit} color="success">Submit</Button>
          <Button onClick={cancel} color="warning">Cancel</Button>
        </div>
      </div>
    </div>
  );
};

function state2props(state) {
  console.log("STATE");
  console.log(state);
  return {
    form: state.register
  };
}

export default connect(state2props)(RegistrationForm);
