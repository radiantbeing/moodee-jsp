package dto;

import java.util.ArrayList;

public class Playlist {
	private int id; // Unique
	private String title;
	private String description;
	private ArrayList<Song> songs;
	private static int lastAddedId = 0;
	
	public Playlist() {
		this.songs = new ArrayList<Song>();
	}
	
	public Playlist(String title, String description) {
		this();
		this.id = ++lastAddedId;
		this.title = title;
		this.description = description;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public ArrayList<Song> getSongs() {
		return songs;
	}

	public void setSongs(ArrayList<Song> songs) {
		this.songs = songs;
	}


	
	
}
