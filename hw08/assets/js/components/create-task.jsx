import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import api from '../api';

function CreateTask(props)
{
  function update(ev) {
    let tgt = $(ev.target);
    let data = {};

    if (tgt.attr('name') == "completed")
    {
      data['completed'] = tgt.is(':checked') ? true : false;
    }
    else
    {
      data[tgt.attr('name')] = tgt.val();
    }

    let action =
    {
      type: 'UPDATE_FORM',
      data: data
    };
    props.dispatch(action);
  }

  function submit(ev)
  {
    api.submit_task(props.form);
  }

  let users = (_.map(props.users, (uu) =>
                <option key={uu.id} value={uu.id}>{uu.name}</option>));

  return (
    <div style={{padding: "4ex"}} className="text-right">
      <h2 className="text-center col-md-5 p-4">New Task</h2>

      <FormGroup className="row">
        <Label for="user_id" className="col-md-2">Assign to</Label>
        <Input type="select" name="user_id" value={props.form.user_id}
          onChange={update} className="col-md-1 text-center">
          {users}
        </Input>
      </FormGroup>

      <FormGroup className="row">
        <Label for="title" className="col-md-2">
          Title
        </Label>
        <Input type="text" name="title" value={props.form.title}
          maxLength="75" onChange={update} className="col-md-3"/>
      </FormGroup>

      <FormGroup className="row">
        <Label className="col-md-2" for="description">Description</Label>
        <Input className="col-md-3" type="textarea" name="description" value={props.form.description}
          onChange={update} />
      </FormGroup>

      <FormGroup className="row">
        <Label for="time_spent" className="col-md-2">Minutes Spent (in increments of 15)</Label>
        <Input type="number" name="time_spent" min="0" step="15"
          value={props.form.time_spent} onChange={update} className="col-md-3"/>
      </FormGroup>

      <FormGroup check className="row">
        <div className="offset-md-1 col-md-2">
          <Label check>
            <Input type="checkbox" name="completed" onChange={update}
              checked={props.form.completed ? "checked" : false} />
            Completed
          </Label>
        </div>

        <div className="col-md-3">
          <br />
          <Button  onClick={submit} color="primary">Submit</Button>
        </div>
      </FormGroup>

    </div>
  );
};

function state2props(state) {
  return {
    form: state.form,
    users: state.users
  };
}

export default connect(state2props)(CreateTask);
