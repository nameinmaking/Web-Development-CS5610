import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Dashboard from './user-dashboard';
import CreateTask from './create-task';

export default function Main(props)
{
  return (
    <div>
      <Route path="/" exact={true} render={() =>
        <Dashboard tasks={props.tasks} user={props.user} />
      } />

      <Route path="/tasks" exact={true} render={() =>
        <CreateTask />
      } />
    </div>
  );
}
