package dao;

import java.util.ArrayList;
import dto.Playlist;
import dto.Song;

public class PlaylistRepository {

	private ArrayList<Playlist> listOfPlaylists = new ArrayList<Playlist>();
	private static PlaylistRepository instance = new PlaylistRepository();
	
	public static PlaylistRepository getInstance() {
		return instance;
	}
	
	public PlaylistRepository() {
//		Playlist lofi = new Playlist("과제할 때 좋은 Lo-Fi 플레이리스트", "과제할 땐 역시 잔잔하고 집중력을 올려주는 Lo-Fi 음악만 한 것이 없죠. 간단한 간식거리와 함께 책상에 앉아 과제에 집중해봐요.");
//		addSong(new Song("g58IRxSkioo", "Flashback Magic", "Zmeyev") , lofi);
//		addSong(new Song("Mnx3X48PzOo", "Supertele ", "Undo."), lofi);
//		addSong(new Song("AmO0a-165zg", "rain on us ", "SanelliX"), lofi);
//
//		Playlist afternoon = new Playlist("햇살과 함께 즐기는 오후의 플레이리스트", "오후의 따스한 햇살이 우릴 반겨주고 있네요. 오늘은 한 마리의 고양이가 되어보도록 하죠. 편한 장소 아무곳에나 누워 휴식을 취해봅시다.");
//		addSong(new Song("z5gulnCWcxQ", "Daydreaming", "92914"), afternoon);
//		addSong(new Song("pnY7m5CK-as", "Seven", "Men I Trust"), afternoon);
//		addSong(new Song("zDqx8T1dJOc", "Domino", "ADOY"), afternoon);
//
//		Playlist hip_rnb = new Playlist("감각적인 힙합과 R&amp;B 플레이리스트", "너무 쎈 힙합은 싫다면 R&amp;B를 곁들인 힙합은 어떠세요? 분위기와 감성이 가득한 플레이리스트를 들으며 감정을 느껴보세요.");
//		addSong(new Song("1sDyWB3qESk", "Snow Sweeping(제설)", "GIRIBOY(기리보이)"), hip_rnb);
//		addSong(new Song("MC6HbNML5MY", "One Snowy Day (Feat. SOLE)", "GIRIBOY(기리보이)"), hip_rnb);
//		addSong(new Song("zpmKEscgS50", "LOST (Feat. 문수진 Moon Sujin)", "Khakii 카키"), hip_rnb);
//
//		listOfPlaylists.add(lofi);
//		listOfPlaylists.add(afternoon);
//		listOfPlaylists.add(hip_rnb);
	}

	public ArrayList<Playlist> getAllPlaylists() {
		return listOfPlaylists;
	}

	public void addPlaylist(Playlist playlist) {
		listOfPlaylists.add(playlist);
	}

	public void addSong(Song song, Playlist playlist) {
		playlist.getSongs().add(song);
	}
	
	public Song getRandomSong(Playlist playlist) {
		ArrayList<Song> songs = playlist.getSongs();
		int index = (int)(Math.random() * songs.size());
		try {
			return songs.get(index);
		} catch (Exception e) {
			return null;
		}
	}
	
	public Playlist getPlaylistById(int id) {
		for(Playlist pl: listOfPlaylists) {
			if (id == pl.getId())
				return pl;
		}
		return null;
	}
}