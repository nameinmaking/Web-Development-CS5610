import React from 'react';
import Task from './task';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row } from 'reactstrap';

import EditTask from './edit-task';

export default function Dashboard(props)
{
  let assigned = _.map(props.tasks, function(tt)
  {
    if (props.user == tt.user.id) {
      return <Task key={tt.id} task={tt} id={tt.id} type={"self"} />;
    }
  });

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
