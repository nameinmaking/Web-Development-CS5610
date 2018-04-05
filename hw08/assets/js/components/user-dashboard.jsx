import React from 'react';
import Task from './task';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row } from 'reactstrap';

import EditTask from './edit-task';

// Renders the edit form (hidden by default) and the tasks;
// adapted from Nat's lecture notes
export default function Dashboard(props) {
  // Tasks assigned to the user
  let assigned = _.map(props.tasks, function(tt) {
    if (props.user == tt.user.id) {
      return <Task key={tt.id} task={tt} id={tt.id} type={"self"} />;
    }
  });
  // Tasks created by the user and assigned to other users
  let created = _.map(props.tasks, function(tt) {
    if (props.user == tt.creator.id && props.user != tt.user.id) {
      return <Task key={tt.id} task={tt} id={tt.id} type={"other"} />;
    }
  });

  return (
    <div >
      <Route path="/" exact={true} render={() =>
        <EditTask />
      } />
      <h3 className="col-md-3 text-center">Tasks Assigned <i>to</i> you:</h3>
      <Row>{assigned}</Row>
      <h3 className="col-md-3 text-center">Tasks Assigned <i>by</i> you:</h3>
      <Row>{created}</Row>
    </div>
  );
}
