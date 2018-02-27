// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons()
{
  $('.startbutton').each( (_, bb) => {
    let id = $(bb).data('id');

    //debug marker
    console.log("Task ID: ",id);

    if (id != "") {
      $(bb).text("Stop");
      $(bb).css('color','red');
    }
    else {
      $(bb).text("Start");
      $(bb).css('color','white');
    }
  });
}

function set_button(task_id, id) {
  $('.startbutton').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('id', id);
    }
  });
  update_buttons();
}

function start(task_id,time) {
  let text = JSON.stringify({
    sprintcycle: {
        task_id: task_id,
        start_time: time,
        end_time: time,
        start: true
      },
  });

  //debug marker
  console.log("Path: ", sprintcycle_path);

  $.ajax(sprintcycle_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    //debug marker
    success: (resp) => { console.log("Response: ", resp); set_button(task_id, resp.data.id); },
    error: (resp) => { console.log(resp); },
  });
}

function stop(task_id, id, time)
{
  //debug marker
  console.log("Stop Time: ",time);
  let text = JSON.stringify({
    sprintcycle: {
        end_time: time,
        start: false
      },
  });

  //debug marker
  console.log("Stop Path: ",sprintcycle_path);
  $.ajax(sprintcycle_path + "/" + id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    //debug marker
    success: (resp) => { console.log(resp); set_button(task_id,""); },
    error: (resp) => { console.log(resp); },
  });
}

function start_click(ev)
{
  //debug marker
  console.log("Inside start_click()");
  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let id = btn.data('id');
  let utc_time = new Date();

  // Convert Current time to EST time
  let time = new Date(utc_time.getTime()+(-300)*60*1000);

  //debug marker
  console.log("Start Time: ",time);


  if (id != "") {
    //debug marker
    console.log("**STOP**",time);
    stop(task_id, id, time);
  }
  else {
    //debug marker
    console.log("**START**");
    start(task_id, time);
  }
}

function init_start()
{
  //debug marker
  console.log("Inside init_start()");
  if (!$('.startbutton')) {
    return;
  }

  //debug marker
  console.log($('.startbutton'));
  $('.startbutton').click(start_click);

  update_buttons();
}

$(init_start);
