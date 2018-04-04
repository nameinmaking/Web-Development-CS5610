import React from 'react';
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';
import { Card, CardBody, CardHeader, Row, Col, Button } from 'reactstrap';

import api from '../api';

// Renders the details of an individual task as a card
function Task(props) {
  let task = props.task;
  // Decide whether to display the assignee or the assigner
  let assign = props.type == "self" ?
    <p><b>Assigned By: </b>{task.creator.name} </p>
      : <p><b>Assigned To: </b>{task.user.name} </p>

  // Sends a request to delete the task
  function delete_task() {
    api.delete_task(task.id);
  }

  // Displays the edit form, populates the hidden field with the task id, and
  // clears all other fields
  function edit_task() {
    $("#edit-form").show();
      props.dispatch({
        type: 'CLEAR_FORM',
      });
    $('input[name="id"]').val(task.id);
  }

  // Returns the task details as a Bootstrap card element
  return (

    <Col md="3">
      <Card body inverse style={{ backgroundColor: '#333', borderColor: '#333' }}>
        <CardHeader className="text-center ch">
          <Row>
              <h2> {task.title} </h2>
          </Row>
        </CardHeader>
        <CardBody>
          <div>
            {assign}
            <p><b>Completed: </b>{task.completed ? "Yes" : "No"}</p>
            <p><b>Time Spent: </b>{task.time_spent} &nbsp;<i>mins</i></p>
            <p><b>Description: </b>{task.description}</p>
          </div>
          <Row className="text-center">
            <div className="col-md-3 p-4 text-center">
              <Button type="button" outline color="warning" onClick={edit_task}>Edit</Button>
            </div>
            <div className="col-md-3 p-4 text-center">
              <Button type="button" outline color="danger" onClick={delete_task}>Delete</Button>
            </div>

          </Row>
        </CardBody>
      </Card>
    </Col>
  );
}

function state2props(state) {
  return {
    form: state.form,
    users: state.users
  };
}

export default connect(state2props)(Task);
