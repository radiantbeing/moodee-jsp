const manageSelect = document.querySelector(".manage__select");
		manageSelect.addEventListener("change", (e) => {
			const selectedValue = e.target.options[e.target.selectedIndex].value;
			location.href="?category=" + selectedValue;
		});
		
function checkPlaylistForm() {
	const form = document.playlist_form;
	if (form.playlist_title.value == "") {
		alert("플레이리스트의 이름을 입력해주세요");
		form.playlist_title.focus();
		return false;
	}
	if (form.playlist_description.value == "") {
		alert("플레이리스트의 설명을 입력해주세요");
		form.playlist_description.focus();
		return false;
	}
	form.submit();
}

function checkSongForm() {
	const form = document.song_form;
	if (form.song_playlist.value == "") {
		alert("곡이 포함될 플레이리스트를 선택해주세요");
		form.song_playlist.focus();
		return false;
	}
	if (form.song_videoId.value == "") {
		alert("유튜브 영상 ID를 입력해주세요");
		form.song_videoId.focus();
		return false;
	}
	if (form.song_title.value == "") {
		alert("곡명을 입력해주세요");
		form.song_title.focus();
		return false;
	}
	if (form.song_artist.value == "") {
		alert("아티스트를 입력해주세요");
		form.song_artist.focus();
		return false;
	}
	form.submit();
}

function checkPostForm() {
	const form = document.post_form;
	if (form.post_videoId.value == "") {
		alert("유튜브 영상 ID를 입력해주세요");
		form.post_videoId.focus();
		return false;
	}
	if (form.post_songTitle.value == "") {
		alert("곡명을 입력해주세요");
		form.post_songTitle.focus();
		return false;
	}
	if (form.post_artist.value == "") {
		alert("아티스트를 입력해주세요");
		form.post_artist.focus();
		return false;
	}
	if (form.post_article.value == "") {
		alert("내용을 입력해주세요");
		form.post_article.focus();
		return false;
	}
	form.submit();
}

function checkGeneralForm() {
	const form = document.general_form;
	if (form.general_logo.value == "") {
		alert("로고를 업로드해주세요");
		form.general_logo.focus();
		return false;
	}
	form.submit();
}