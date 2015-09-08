$(document).ready(function(){
  console.log('hi jquery');

//will get all my videos as soon as doc is ready
  getVideos();


//event listener
$('#submit').on('click', addVideo)



});

// Add a video
function addVideo(event){
  console.log('meeeemmmmee');
  video = {link: $('#link').val(), title: $('#title').val() };
  debugger;
  $.post('/videos', video, function(response){
    console.log(response);
    appendNewVideo(response);
    $('#link').val('');
    $('#title').val('');
  })
}






function getVideos(){
  //ajax request to the DB to recieve all the tasks
  request('GET', '/videos', null).done(function(response){
    console.log(response);
    // debugger;
    $.each(response, function(index, video){
      console.log(video)
      // debugger;
      appendNewVideo(video);
    })
  });
};

function appendNewVideo(video) {
  //add this video to the div memetube ajax
  $('<iframe width="460" height="315" src="'+  video.link  +'" frameborder="0" allowfullscreen></iframe>').appendTo('#videos-ajax')
};






function request(method, url, data){
  return $.ajax({
    method: method,
    url: url,
    dataType: 'json',
    data: data
  })
}