package dto;

public class Song {
	private String id; // VideoId, Unique
	private String title;
	private String artist;
	private String thumbnailURL;
	
	public Song() {
		super();
	}
	
	public Song(String id, String title, String artist) {
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.thumbnailURL = "https://img.youtube.com/vi/" + id + "/0.jpg";
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getThumbnailURL() {
		return thumbnailURL;
	}

	public void setThumbnailURL(String thumbnailURL) {
		this.thumbnailURL = thumbnailURL;
	}

}
