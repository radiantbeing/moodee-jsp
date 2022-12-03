// Toast message function
function toast(msg, icon) {
  Toastify({
    text: msg,
    duration: 2000,
    avatar: "./static/images/" + icon + ".svg",
    gravity: "top", // `top` or `bottom`
    position: "center", // `left`, `center` or `right`
    style: {
      background: "#000000",
      paddingLeft: "12vw",
      paddingRight: "12vw",
      marginTop: "71px",
      borderRadius: "4px",
      textAlign: "left",
    },
  }).showToast();
}

function getQSValue(key) {
  return new URLSearchParams(location.search).get(key);
}

const playlist_id = getQSValue("playlist_id");
let language;
try {
  language = document.cookie
    .split("; ")
    .find((row) => row.startsWith("language"))
    .split("=")[1];
} catch (error) {
  console.log("Not exist language cookie");
}

// Did not select playlist
if (!playlist_id) {
  let msg = "플레이리스트를 선택해주세요";
  if (language == "en") msg = "Please select a playlist";
  toast(msg, "warning");
}

// YouTube iframe API functions
var tag = document.createElement("script");

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName("script")[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
let songs;
let currentSongIndex;
function onYouTubeIframeAPIReady() {
  player = new YT.Player("player", {
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange,
    },
  });
}

function onPlayerReady() {
  function shuffleArray(array) {
    array.sort(() => Math.random() - 0.5);
  }
  if (!playlist_id) return;
  fetch("./shuffle_process.jsp?playlist_id=" + playlist_id)
    .then((res) => res.json())
    .then((data) => {
      songs = data.songs;
      shuffleArray(songs);

      player.cueVideoById(songs[0].id);

      currentSongIndex = 0;
      
      const coverImg = document.querySelector(".player > .player__song > .player__img");
      coverImg.style.backgroundSize = "contain";
      coverImg.style.backgroundColor = "black";

      const videoId = songs[currentSongIndex].id;
      document.querySelector(".player__img").style.backgroundImage =
        'url("https://img.youtube.com/vi/' + videoId + '/0.jpg")';
      document.querySelector(".player__title").innerHTML =
    	  '<a href="https://www.youtube.com/watch?v=' +
        songs[currentSongIndex].id +
        '" target="_blank">' +
        songs[currentSongIndex].title +
        "</a>";
      document.querySelector(".player__sub--id").innerHTML =
        songs[currentSongIndex].artist;
      document.querySelector(".player__sub--time").innerHTML = "00:00";
      let readyMsg = "플레이리스트 재생 준비 완료";
      if (language == "en") readyMsg = "Playlist ready to play";
      toast(readyMsg, "done");

      const volDownBtn = document.querySelector(".player__control--vol-down");
      const prevBtn = document.querySelector(".player__control--prev");
      const playBtn = document.querySelector(".player__control--play");
      const pauseBtn = document.querySelector(".player__control--pause");
      const nextBtn = document.querySelector(".player__control--next");
      const volUpBtn = document.querySelector(".player__control--vol-up");
      

      volDownBtn.onclick = () => player.setVolume(player.getVolume() - 5);
      prevBtn.onclick = () => {
        if (currentSongIndex == 0) {
          let startMsg = "재생목록의 처음입니다";
          if (language == "en") startMsg = "First song on this playlist";
          toast(startMsg, "warning");
          return;
        }
        player.loadVideoById(songs[--currentSongIndex].id);
      };
      playBtn.onclick = () => player.playVideo();
      pauseBtn.onclick = () => player.pauseVideo();
      nextBtn.onclick = () => {
        if (currentSongIndex == songs.length - 1) {
          let endMsg = "재생목록의 끝입니다";
          if (language == "en") endMsg = "Last song on this playlist";
          toast(endMsg, "warning");
          return;
        }
        player.loadVideoById(songs[++currentSongIndex].id);
      };
      volUpBtn.onclick = () => player.setVolume(player.getVolume() + 5);
    });
}

function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING) {
    const playBtn = document.querySelector(".player__control--play");
    const pauseBtn = document.querySelector(".player__control--pause");
    playBtn.classList.add("active");
    pauseBtn.classList.remove("active");
    const videoId = songs[currentSongIndex].id;
    document.querySelector(".player__img").style.backgroundImage =
      'url("https://img.youtube.com/vi/' + videoId + '/0.jpg")';
    document.querySelector(".player__title").innerHTML =
    	  '<a href="https://www.youtube.com/watch?v=' +
        songs[currentSongIndex].id +
        '" target="_blank">' +
        songs[currentSongIndex].title +
        "</a>";
    document.querySelector(".player__sub--id").innerHTML =
      songs[currentSongIndex].artist;
    const duration = player.getDuration();
    const minute = String(Math.floor(duration / 60));
    const second = String(Math.floor(duration % 60));
    document.querySelector(".player__sub--time").innerHTML =
      minute.padStart(2, "0") + ":" + second.padStart(2, "0");
    return;
  }
  if (event.data == YT.PlayerState.ENDED) {
    if (currentSongIndex == songs.length - 1) {
      let lastMsg = "재생목록의 끝입니다";
      if (language == "en") lastMsg = "First song on this playlist";
      toast(lastMsg, "warning");
      return;
    }
    player.loadVideoById(songs[++currentSongIndex].id);
    return;
  }
  if (event.data == YT.PlayerState.PAUSED) {
    const playBtn = document.querySelector(".player__control--play");
    const pauseBtn = document.querySelector(".player__control--pause");
    playBtn.classList.remove("active");
    pauseBtn.classList.add("active");
  }
}
