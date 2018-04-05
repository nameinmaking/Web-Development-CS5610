import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import api from '../api';

// Renders the edit form; adapted from Nat's lecture notes
function EditTask(props) {
  function update(ev) {
    let tgt = $(ev.target);
    let data = {};
    if (tgt.attr('name') == "completed") {
      data['completed'] = tgt.is(':checked') ? true : false;
    }
    else {
      data[tgt.attr('name')] = tgt.val();
    }
    // Send the hidden task id as well, which is needed to update the task
    data['id'] = $('input[name="id"]').val();
    let action = {
      type: 'UPDATE_FORM',
      data: data
    };
    props.dispatch(action);
  }

  // Sends a request to update the task
  function submit(ev) {
    api.edit_task(props.form);
  }

  // Clears all of the fields and closes the form
  function cancel() {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
    $("#edit-form").hide();
  }

  // Grabs all of the users to populate the dropdown
  let users = (_.map(props.users, (uu) =>
  <option key={uu.id} value={uu.id}>{uu.name}</option>));

  return (
    <div id="edit-form" style={{padding: "4ex"}}>
      <h2>Edit Task</h2>
      <FormGroup>
        <Label for="user_id">Assignee</Label>
        <Input type="select" name="user_id" value={props.form.user_id}
          onChange={update}>
          {users}
        </Input>
      </FormGroup>
      <FormGroup>
        <Input type="text" name="title" value={props.form.title}
          maxLength="75" onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="description">Description</Label>
        <Input type="textarea" name="description" value={props.form.description}
          onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="time_spent">Minutes Spent (in increments of 15)</Label>
        <Input type="number" name="time_spent" min="0" step="15"
          value={props.form.time_spent} onChange={update} />
      </FormGroup>
      <FormGroup check>
        <Label check>
          <Input type="checkbox" name="completed" onChange={update}
            checked={props.form.completed ? "checked" : false} />
          Completed
        </Label>
      </FormGroup>
      <FormGroup>
        <Input type="hidden" name="id" />
      </FormGroup>
      <Button onClick={submit} color="primary">Submit</Button>
      <Button onClick={cancel} color="primary">Cancel</Button>
    </div>
  );
};

function state2props(state) {
  return {
    form: state.form,
    users: state.users
  };
}

export default connect(state2props)(EditTask);
